import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submissionfundamental/provider/preference_provider.dart';
import 'package:submissionfundamental/provider/scheduling_provider.dart';

class SettingPage extends StatelessWidget {
  static const routeName = '/setting_resto';

  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BoddySettingPage(),
    );
  }
}

class BoddySettingPage extends StatelessWidget {
  const BoddySettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(children: <Widget>[
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 30, left: 30),
                  child: Text(
                    'Setting Restaurant ',
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Consumer<PreferencesProvider>(
                    builder: (context, provider, child) {
                  return ListView(
                    shrinkWrap: true,
                    children: [
                      Material(
                        child: ListTile(
                          title: Text(
                            'Restaurant Notification',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          subtitle: Text(
                            "Enable notification",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          trailing: Consumer<SchedulingProvider>(
                            builder: (context, scheduled, _) {
                              return Switch.adaptive(
                                value: provider.isDailyNotificationActive,
                                onChanged: (value) async {
                                  scheduled.scheduledResto(value);
                                  provider.enableDailyNotification(value);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }))
          ])
    ]));
  }
}
