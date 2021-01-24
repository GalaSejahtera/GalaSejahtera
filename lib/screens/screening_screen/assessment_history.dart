import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gala_sejahtera/models/auth_credentials.dart';
import 'package:gala_sejahtera/services/rest_api_services.dart';

class AssessmentHistoryScreen extends StatefulWidget {
  @override
  _AssessmentHistoryScreenState createState() =>
      _AssessmentHistoryScreenState();
}

class _AssessmentHistoryScreenState extends State<AssessmentHistoryScreen> {
  RestApiServices restApiServices = RestApiServices();
  List reports = [];

  String getUserId() {
    String id = Provider.of<AuthCredentials>(context, listen: false).id;
    return id;
  }

  @override
  void initState() {
    super.initState();
    getReports();
  }

  void getReports() async {
    reports = await restApiServices.getReports(getUserId());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Assessment History'),
      ),
      backgroundColor: Color(0xff60A1DD),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Covid-19 Self Assessment History",
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
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: reports.length,
                itemBuilder: (context, index) {
                  return Card(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      // ListTile(
                      //   title: Text(reports[index]),
                      // ),
                    ],
                  ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
