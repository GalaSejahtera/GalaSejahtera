import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gala_sejahtera/models/covid_cases_records.dart';
import 'package:gala_sejahtera/services/rest_api_services.dart';

//testing screen

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();

  static const String id = 'second_screen';
}

class _SecondScreenState extends State<SecondScreen> {
  RestApiServices restApiServices = RestApiServices();

  Future<CovidCasesRecords> covidCasesRecords;

  @override
  void initState() {
    super.initState();
    covidCasesRecords = restApiServices.fetchCovidCasesRecordsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('This is second page'),
      ),
      body: Center(
        child: FutureBuilder<CovidCasesRecords>(
          future: covidCasesRecords,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.states.length,
                itemBuilder: (context, index) {
                  StateModel state = snapshot.data.states[index];
                  return Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(state.name),
                          Text(" " + state.total.toString()),
                        ],
                      ),
                    ],
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
