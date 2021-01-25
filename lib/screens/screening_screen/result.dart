import 'dart:convert';

import 'package:flutter/material.dart';
import '../../widgets/rounded_button.dart';
import 'assessment_question.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:provider/provider.dart';
import 'package:gala_sejahtera/models/auth_credentials.dart';
import 'package:gala_sejahtera/services/rest_api_services.dart';

AssessmentQuestion assessmentQuestion = AssessmentQuestion();

class StatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Widget child;
  const StatefulWrapper({@required this.onInit, @required this.child});
  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<StatefulWrapper> {
  @override
  void initState() {
    if (widget.onInit != null) {
      widget.onInit();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class ResultScreen extends StatelessWidget {
  List<String> questions = assessmentQuestion.getAllQuestion();
  RestApiServices restApiServices = RestApiServices();

  Map data = {};
  List<bool> answers = [];

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    answers = data['answers'];
    String id = Provider.of<AuthCredentials>(context).id;

    bool hasSymptom() {
      List<bool> first = answers.sublist(0, 4); //Q1 ~ Q4
      List<bool> last = answers.sublist(4, 11); //Q5 ~ Q11
      if (first.where((element) => element == true).length >= 2)
        return true;
      else if (last.where((element) => element == true).length >= 2)
        return true;
      else
        return false;
    }

    void createReport() async {
      await restApiServices.createReport(id, hasSymptom(), answers);
    }

    return StatefulWrapper(
      onInit: () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          SweetAlert.show(
            context,
            subtitle: hasSymptom()
                ? 'Your assessment tested high risk.\nPlease stay at home'
                : 'Your assessment tested low risk.\nYou can cuti-cuti Malaysia',
          );
        });
        if (id != null) {
          createReport();
        }
      },
      child: Scaffold(
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
                          title: Text(answers[index] == true ? 'Yes' : 'No'),
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
      ),
    );
  }
}
