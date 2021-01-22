import 'dart:ui';

import 'package:flutter/material.dart';
import '../../widgets/rounded_button.dart';
import 'package:provider/provider.dart';
import 'package:gala_sejahtera/models/auth_credentials.dart';
import 'package:sweetalert/sweetalert.dart';

class ScreeningScreen extends StatefulWidget {
  @override
  _ScreeningScreenState createState() => _ScreeningScreenState();
}

class _ScreeningScreenState extends State<ScreeningScreen> {
  @override
  Widget build(BuildContext context) {
    String token = Provider.of<AuthCredentials>(context).accessToken;

    return Scaffold(
      backgroundColor: Color(0xff60A1DD),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Covid-19 Self Assessment",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 44),
            RoundedButton(
              title: 'Take Assessment',
              color: Colors.black,
              onPressed: () => Navigator.pushNamed(context, '/Assessment'),
            ),
            SizedBox(
              height: 16,
            ),
            RoundedButton(
                title: 'View History',
                color: Colors.black,
                onPressed: () {
                  if (token != null) {
                    Navigator.pushNamed(context, '/AssessmentHistory');
                  } else {
                    SweetAlert.show(
                      context,
                      subtitle: 'Please login to access the history',
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
