import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gala_sejahtera/widgets/custom_field.dart';
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
          panEnabled: true, // Set it to false to prevent panning.
          boundaryMargin: EdgeInsets.all(20),
          minScale: 0.5,
          maxScale: 3.0,
          child: svg,
        ),
        Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: CustomField(
                keyboardType: TextInputType.text,
                obscureText: false,
                onChanged: (value) {
                  // do nothing
                },
                hintText: 'Search for district',
              ),
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
          ],
        ),
      ]),
    );
  }
}
