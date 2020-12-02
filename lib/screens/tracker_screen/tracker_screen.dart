import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gala_sejahtera/widgets/display_box.dart';

class TrackerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only(top: 40),
      child: Row(children: <Widget>[
        DisplayBox(
          title: '10',
          description: "Nearby Symptomatic Users",
        ),
        DisplayBox(
          title: '20',
          description: "Covid-19 Cases in Your District",
        ),
      ]),
    );
  }
}
