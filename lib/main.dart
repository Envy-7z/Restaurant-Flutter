import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:submissionfundamental/data/api/api_service.dart';
import 'package:submissionfundamental/data/db/database_helper.dart';
import 'package:submissionfundamental/data/model/restauran_response.dart';
import 'package:submissionfundamental/provider/database_provider.dart';
import 'package:submissionfundamental/provider/detail_provider.dart';
import 'package:submissionfundamental/provider/preference_provider.dart';
import 'package:submissionfundamental/provider/resto_provider.dart';
import 'package:submissionfundamental/provider/scheduling_provider.dart';
import 'package:submissionfundamental/provider/search_provider.dart';
import 'package:submissionfundamental/ui/favorite_page.dart';
import 'package:submissionfundamental/ui/login_page.dart';
import 'package:submissionfundamental/ui/main_page.dart';
import 'package:submissionfundamental/ui/restodetail_page.dart';
import 'package:submissionfundamental/ui/setting_page.dart';
import 'package:submissionfundamental/utils/background_service.dart';
import 'package:submissionfundamental/utils/navigation.dart';
import 'package:submissionfundamental/utils/notification_helper.dart';
import 'package:submissionfundamental/utils/preferences_helper.dart';
import 'package:submissionfundamental/utils/styles.dart';
import 'package:submissionfundamental/ui/restosearch_page.dart';
import 'package:submissionfundamental/widget/nav_bar.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => RestoProvider(apiService: ApiService()),
          ),
          ChangeNotifierProvider(
            create: (_) =>
                RestoDetailProvider(apiService: ApiService(), id: ''),
          ),
          ChangeNotifierProvider(
            create: (_) => SearchRestoProvider(apiService: ApiService()),
          ),
          ChangeNotifierProvider(
            create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
          ),
          ChangeNotifierProvider<SchedulingProvider>(
            create: (_) => SchedulingProvider(),
          ),
          ChangeNotifierProvider<PreferencesProvider>(
            create: (_) => PreferencesProvider(
              preferencesHelper: PreferencesHelper(
                sharedPreferences: SharedPreferences.getInstance(),
              ),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Submission App',
          theme: ThemeData(
            primaryColor: primaryColor,
            scaffoldBackgroundColor: primaryColor,
            textTheme: myTextTheme,
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
                .copyWith(secondary: Colors.blue),
          ),
          navigatorKey: navigatorKey,
          initialRoute: LoginPage.routeName,
          routes: {
            NavBar.routeName: (context) => NavBar(),
            MainPage.routeName: (context) => const MainPage(),
            SettingPage.routeName: (context) => const SettingPage(),
            SearchRestoPage.routeName: (context) => const SearchRestoPage(),
            FavoritePage.routeName: (context) => const FavoritePage(),
            DetailRestoPage.routeName: (context) => DetailRestoPage(
                resto:
                    ModalRoute.of(context)?.settings.arguments as Restaurant),
            LoginPage.routeName: (context) => const LoginPage(),
          },
        ));
  }
}
