import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gala_sejahtera/screens/home_screen/home_screen.dart';
import 'package:gala_sejahtera/screens/news_screen/news_navigator.dart';
import 'package:gala_sejahtera/screens/screening_screen/screening_navigator.dart';
import 'package:gala_sejahtera/screens/tracker_screen/tracker_screen.dart';

class NavBar extends StatefulWidget {
  static const String id = 'nav_bar';

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    TrackerScreen(),
    NewsNavigator(),
    ScreeningNavigator(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      backgroundColor: Color(0xff60A1DD),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Tracker',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Screen',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
