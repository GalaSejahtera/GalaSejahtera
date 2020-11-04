import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gala_sejahtera/screens/second/second_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('This is home page'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Next page'),
          onPressed: () async {
            Navigator.pushNamed(context, SecondScreen.id);
          },
        ),
      ),
    );
  }
}
