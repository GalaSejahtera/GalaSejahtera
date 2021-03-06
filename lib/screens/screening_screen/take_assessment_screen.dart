import 'package:flutter/material.dart';

import '../../widgets/rounded_button.dart';
import 'assessment_question.dart';

AssessmentQuestion assessmentQuestion = AssessmentQuestion();

class TakeAssessmentScreen extends StatefulWidget {
  @override
  _TakeAssessmentScreenState createState() => _TakeAssessmentScreenState();
}

class _TakeAssessmentScreenState extends State<TakeAssessmentScreen> {
  List<bool> answers = [];

  @override
  void dispose() {
    super.dispose();
    assessmentQuestion.reset();
  }

  void saveAnswer(bool answer) {
    answers.add(answer);
    if (assessmentQuestion.isLast()) {
      Navigator.pushReplacementNamed(context, '/Result', arguments: {
        'answers': answers,
      });
    } else {
      setState(() {
        assessmentQuestion.nextQuestion();
      });
    }
  }

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
              assessmentQuestion.getQuestion(),
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
              color: Colors.green,
              onPressed: () {
                saveAnswer(true);
              },
            ),
            SizedBox(
              height: 16,
            ),
            RoundedButton(
              title: 'No',
              color: Colors.red,
              onPressed: () {
                saveAnswer(false);
              },
            )
          ],
        ),
      ),
    );
  }
}
