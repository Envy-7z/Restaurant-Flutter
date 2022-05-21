import 'package:flutter/material.dart';
import 'package:submissionfundamental/ui/login_page.dart';
import 'package:submissionfundamental/ui/main_page.dart';
import 'package:submissionfundamental/ui/restodetail_page.dart';
import 'package:submissionfundamental/utils/styles.dart';
import 'package:submissionfundamental/ui/restosearch_page.dart';

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
        textTheme: myTextTheme,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(secondary: Colors.blue),
      ),
      initialRoute: LoginPage.routeName,
      routes: {
        // HomePage.routeName: (context) => const HomePage(), --> ini submission 1
        // DetailPage.routeName: (context) => DetailPage( --> ini submission 1
        //   restaurant: ModalRoute.of(context)?.settings.arguments as Restaurant,
        // ), --> ini submission 1
        // LoginPage.routeName : (context) => const LoginPage(), --> ini submission 1

        MainPage.routeName: (context) => const MainPage(),
        SearchRestoPage.routeName: (context) => const SearchRestoPage(),
        DetailRestoPage.routeName: (context) => DetailRestoPage(
            id: ModalRoute.of(context)!.settings.arguments == null
                ? 'null'
                : ModalRoute.of(context)!.settings.arguments as String),
        LoginPage.routeName: (context) => const LoginPage()
      },
    );
  }
}
