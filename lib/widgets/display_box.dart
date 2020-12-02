import 'package:flutter/material.dart';

class DisplayBox extends StatelessWidget {
  final String title;
  final String description;

  const DisplayBox({this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Container(
        height: 140,
        margin: EdgeInsets.all(10),
        child: Material(
          elevation: 5.0,
          color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(30.0),
          child: Align(
              alignment: Alignment.center,
              child: Column(children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: Color(0xffFD3030).withOpacity(0.7),
                    fontSize: 80,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
              ])),
        ),
      ),
    );
  }
}
