import 'package:flutter/material.dart';
import 'package:submissionfundamental/model/local_restauran.dart';
import 'package:submissionfundamental/ui/detail_page.dart';
import 'package:submissionfundamental/ui/home_page.dart';
import 'package:submissionfundamental/ui/login_page.dart';
import 'package:submissionfundamental/utils/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Submission',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: primaryColor,
        scaffoldBackgroundColor: primaryColor,
        textTheme: myTextTheme, colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(secondary: Colors.blue),
      ),
      initialRoute: LoginPage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        DetailPage.routeName: (context) => DetailPage(
          restaurant: ModalRoute.of(context)?.settings.arguments as Restaurant,
        ),
        LoginPage.routeName : (context) => const LoginPage(),
      },
    );
  }
}


