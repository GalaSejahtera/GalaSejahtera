import 'package:flutter/material.dart';
import '../../widgets/rounded_button.dart';
import 'assessment_question.dart';
import 'package:sweetalert/sweetalert.dart';

AssessmentQuestion assessmentQuestion = AssessmentQuestion();

class ResultScreen extends StatelessWidget {
  List<String> questions = assessmentQuestion.getAllQuestion();

  Map data = {};
  List<String> answers = [];

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    answers = data['answers'];

    bool hasSymptom() {
      List<String> first = answers.sublist(0, 4); //Q1 ~ Q4
      List<String> last = answers.sublist(4, 11); //Q5 ~ Q11
      if (first.where((element) => element == 'Yes').length >= 2)
        return true;
      else if (last.where((element) => element == 'Yes').length >= 2)
        return true;
      else
        return false;
    }

    return Scaffold(
      backgroundColor: Color(0xff60A1DD),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Covid-19 Self Assessment Result",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  return Card(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Text(questions[index]),
                      ),
                      ListTile(
                        title: Text(answers[index]),
                      ),
                    ],
                  ));
                },
              ),
            ),
            RoundedButton(
              title: 'Finish',
              color: Colors.black,
              onPressed: () => Navigator.pushNamed(context, '/'),
            ),
          ],
        ),
      ),
    );
  }
}
