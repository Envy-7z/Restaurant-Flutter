import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:submissionfundamental/data/api/api_service.dart';
import 'package:submissionfundamental/main.dart';
import 'package:submissionfundamental/utils/notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static String isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      isolateName,
    );
  }

  static Future<void> callback() async {
    if (kDebugMode) {
      print('Alarm fired!');
    }
    final NotificationHelper notificationHelper = NotificationHelper();
    var result = await ApiService().restaurantList();
    await notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, result);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(isolateName);
    _uiSendPort?.send(null);
  }
}
