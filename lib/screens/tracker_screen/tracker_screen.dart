import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gala_sejahtera/widgets/custom_autocomplete.dart';
import 'package:gala_sejahtera/widgets/custom_field.dart';
import 'package:gala_sejahtera/widgets/custom_iconbutton.dart';
import 'package:gala_sejahtera/widgets/display_box.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TrackerScreen extends StatelessWidget {
  final Widget svg = SvgPicture.asset('assets/images/malaysia.svg',
      semanticsLabel: 'Malaysia Map');

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
          child: svg,
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
                    // do nothing
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
                title: '20',
                description: "Covid-19 Cases in Your District",
              ),
            ]),
            Row(children: <Widget>[
              DisplayBox(
                title: '10',
                description: "Covid-19 Cases in Kuala Lumpur",
                hasClose: true,
              ),
            ]),
          ],
        ),
      ]),
    );
  }
}
