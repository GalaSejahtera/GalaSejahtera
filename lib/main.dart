import 'package:flutter/material.dart';
import 'package:gala_sejahtera/screens/login_screen/login_screen.dart';
import 'package:gala_sejahtera/screens/nav_bar/nav_bar.dart';
import 'package:gala_sejahtera/screens/registration_screen/registration_screen.dart';
import 'package:gala_sejahtera/screens/second/second_screen.dart';

void main() {
  runApp(GalaSejahtera());
}

class GalaSejahtera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: NavBar.id, routes: {
      LoginScreen.id: (context) => LoginScreen(),
      RegistrationScreen.id: (context) => RegistrationScreen(),
      NavBar.id: (context) => NavBar(),
      SecondScreen.id: (context) => SecondScreen(),
      //other screens
    });
  }
}
