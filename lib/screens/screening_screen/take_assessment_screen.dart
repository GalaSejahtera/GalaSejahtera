import 'package:flutter/material.dart';

import '../../widgets/rounded_button.dart';

class TakeAssessmentScreen extends StatefulWidget {
  @override
  _TakeAssessmentScreenState createState() => _TakeAssessmentScreenState();
}

class _TakeAssessmentScreenState extends State<TakeAssessmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Take Assessment'),
      ),
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
            SizedBox(height: 36),
            Text(
              "Have you experienced shortness of breath?",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 44,
            ),
            RoundedButton(
              title: 'Yes',
              color: Colors.black,
              onPressed: () => {print("Yes")},
            ),
            SizedBox(
              height: 16,
            ),
            RoundedButton(
              title: 'No',
              color: Colors.black,
              onPressed: () => {print("No")},
            )
          ],
        ),
      ),
    );
  }
}
