import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gala_sejahtera/models/covid_cases_records.dart';
import 'package:gala_sejahtera/services/rest_api_services.dart';
import 'package:gala_sejahtera/widgets/custom_autocomplete.dart';
import 'package:gala_sejahtera/widgets/custom_iconbutton.dart';
import 'package:gala_sejahtera/widgets/display_box.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TrackerScreen extends StatefulWidget {
  @override
  _TrackerScreenState createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  RestApiServices restApiServices = RestApiServices();

  Future<CovidCasesRecords> covidCasesRecords;
  String selected = "";

  @override
  void initState() {
    super.initState();
    covidCasesRecords = restApiServices.fetchCovidCasesRecordsData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only(top: 40),
      child: Stack(fit: StackFit.expand, children: <Widget>[
        InteractiveViewer(
          panEnabled: true,
          boundaryMargin: EdgeInsets.all(20),
          minScale: 0.5,
          maxScale: 3.0,
          child: SvgPicture.asset('assets/images/malaysia.svg',
              semanticsLabel: 'Malaysia Map'),
        ),
        Positioned(
          bottom: 30,
          left: 30,
          child: CustomIconButton(icon: Icon(Icons.history), onPressed: () {}),
        ),
        Positioned(
          bottom: 30,
          right: 30,
          child: CustomIconButton(
              icon: Icon(Icons.power_settings_new), onPressed: () {}),
        ),
        Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: CustomAutocomplete(
                  onChanged: (value) {
                    setState(() {
                      selected = value;
                    });
                  },
                  hintText: 'Search for district',
                  suggestions: ["Kuala Lumpur", "Selangor", "Johor"]),
            ),
            Row(children: <Widget>[
              DisplayBox(
                title: '10',
                description: "Nearby Symptomatic Users",
              ),
              DisplayBox(
                title: '2000',
                description: "Covid-19 Cases in Your District",
              ),
            ]),
            if (selected != "")
              Row(children: <Widget>[
                DisplayBox(
                  title: '10',
                  description: 'Covid-19 Cases in $selected',
                  hasClose: true,
                  onClose: () {
                    setState(() {
                      selected = "";
                    });
                  },
                ),
              ]),
          ],
        ),
      ]),
    );
  }
}
