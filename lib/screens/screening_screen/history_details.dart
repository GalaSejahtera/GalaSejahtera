import 'package:flutter/material.dart';
import 'assessment_question.dart';

AssessmentQuestion assessmentQuestion = AssessmentQuestion();

class HistoryDetailsScreen extends StatefulWidget {
  @override
  _HistoryDetailsScreenState createState() => _HistoryDetailsScreenState();
}

class _HistoryDetailsScreenState extends State<HistoryDetailsScreen> {
  List<String> questions = assessmentQuestion.getAllQuestion();

  Map data = {};

  List<dynamic> answers = [];

  int index = 0;

  bool hasSymptom = false;

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    answers = data['answers'];
    index = data['index'] + 1;
    hasSymptom = data['hasSymptom'];

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Assessment History'),
          leading: new IconButton(
              icon: new Icon(Icons.arrow_back_rounded),
              onPressed: () => Navigator.pushReplacementNamed(
                  context, '/AssessmentHistory')),
        ),
        backgroundColor: Color(0xff60A1DD),
        body: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Assessment History $index Result: ${hasSymptom ? 'High Risk' : 'Low Risk'}",
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
                          title: Text(answers[index] == true ? 'Yes' : 'No'),
                        ),
                      ],
                    ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
