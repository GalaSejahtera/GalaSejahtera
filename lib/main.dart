import 'package:flutter/material.dart';
import 'package:gala_sejahtera/screens/home/home_screen.dart';
import 'package:gala_sejahtera/screens/login_screen/login_screen.dart';
import 'package:gala_sejahtera/screens/nav_bar/nav_bar.dart';
import 'package:gala_sejahtera/screens/registration_screen/registration_screen.dart';
import 'package:gala_sejahtera/screens/second/second_screen.dart';
import 'package:gala_sejahtera/screens/welcome_screen/welcome_screen.dart';

void main() {
  runApp(GalaSejahtera());
}

class GalaSejahtera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: WelcomeScreen.id, routes: {
      WelcomeScreen.id: (context) => WelcomeScreen(),
      LoginScreen.id: (context) => LoginScreen(),
      RegistrationScreen.id: (context) => RegistrationScreen(),
      HomeScreen.id: (context) => HomeScreen(),
      SecondScreen.id: (context) => SecondScreen(),
      NavBar.id: (context) => NavBar(),
      //other screens
    });
  }
}
