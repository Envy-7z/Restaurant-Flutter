import 'package:flutter/material.dart';
import 'package:submissionfundamental/ui/favorite_page.dart';
import 'package:submissionfundamental/ui/main_page.dart';

import '../ui/setting_page.dart';

class NavBar extends StatefulWidget {
  static const routeName = '/nav_bar';

  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBar();
}

class _NavBar extends State<NavBar> {
  int currentIndex = 0;
  final pages = [const MainPage(), const FavoritePage(), const SettingPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, //
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Favorite'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Setting'),
          ]),
    );
  }
}
