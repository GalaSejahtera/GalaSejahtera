import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gala_sejahtera/models/auth_credentials.dart';
import 'package:gala_sejahtera/models/general_cases.dart';
import 'package:gala_sejahtera/screens/login_screen/login_screen.dart';
import 'package:gala_sejahtera/services/rest_api_services.dart';
import 'package:gala_sejahtera/widgets/custom_autocomplete.dart';
import 'package:gala_sejahtera/widgets/display_box.dart';
import 'package:gala_sejahtera/widgets/rounded_button.dart';
import 'package:provider/provider.dart';

import 'covid_bar_chart.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RestApiServices restApiServices = RestApiServices();
  String selected = "";
  TextEditingController controller = TextEditingController();
  int totalConfirmed = 0, totalActive = 0;

  @override
  void initState() {
    super.initState();
    fetchGeneralCases();
  }

  void fetchGeneralCases() async {
    GeneralCases generalCasesRecords =
        await restApiServices.fetchGeneralCases();
    setState(() {
      totalConfirmed = generalCasesRecords.totalConfirmed;
      totalActive = generalCasesRecords.activeCases;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(children: <Widget>[
            DisplayBox(
              title: totalConfirmed.toString(),
              description: "Total Cases",
            ),
            DisplayBox(
              title: totalActive.toString(),
              description: "Active Cases",
            ),
          ]),
          CovidBarChart(),
          Container(
            margin: EdgeInsets.all(10),
            child: CustomAutocomplete(
                typeAheadController: controller,
                onChanged: (value) {
                  setState(() {
                    selected = value;
                    controller.text = value;
                  });
                },
                hintText: 'Search for district',
                suggestions: ["Kuala Lumpur", "Selangor", "Johor"]),
          ),
          Text(
            //example to get the state from Provider
            'ACCESS TOKEN: ${Provider.of<AuthCredentials>(context).accessToken}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 9.0,
            ),
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: RoundedButton(
                title: 'Login For More Features',
                color: Colors.black,
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
