import 'package:flutter/material.dart';
import 'package:gala_sejahtera/screens/home/home_screen.dart';
import 'package:gala_sejahtera/screens/second/second_screen.dart';

void main() {
  runApp(GalaSejahtera());
}

class GalaSejahtera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: HomeScreen.id, routes: {
      HomeScreen.id: (context) => HomeScreen(),
      SecondScreen.id: (context) => SecondScreen(),
      //other screens

    });
  }
}


