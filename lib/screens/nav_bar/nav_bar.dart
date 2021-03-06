import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gala_sejahtera/models/auth_credentials.dart';
import 'package:gala_sejahtera/screens/home_screen/home_screen.dart';
import 'package:gala_sejahtera/screens/news_screen/news_navigator.dart';
import 'package:gala_sejahtera/screens/screening_screen/screening_navigator.dart';
import 'package:gala_sejahtera/screens/tracker_screen/tracker_screen.dart';
import 'package:provider/provider.dart';
import 'package:sweetalert/sweetalert.dart';

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
      if (!isUserLogin()) {
        if (index == 1) {
          SweetAlert.show(
            context,
            subtitle: 'Login for more features.',
          );
          return;
        }
      }
      _selectedIndex = index;
    });
  }

  bool isUserLogin() {
    String accessToken =
        Provider.of<AuthCredentials>(context, listen: false).accessToken;
    if (accessToken == null) return false;
    return true;
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
        selectedItemColor: Color(0xff60A1DD),
        onTap: _onItemTapped,
      ),
    );
  }
}
