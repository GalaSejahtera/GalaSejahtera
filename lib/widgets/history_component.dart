import 'package:flutter/material.dart';
import 'package:gala_sejahtera/widgets/district_box.dart';

class HistoryComponent extends StatelessWidget {
  final List<String> districts;
  final Function onClose;

  const HistoryComponent({this.districts, this.onClose});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Stack(
        children: [
          Container(
            height: 350,
            margin: EdgeInsets.all(10),
            child: Material(
              elevation: 5.0,
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(30.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Visited district(s) past 14 day",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 290,
                      child: ListView(
                          children: districts
                              .map((d) => DistrictBox(
                                  title: d, color: Color(0xff67cc5a)))
                              .toList()),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              icon: Icon(Icons.cancel_outlined),
              iconSize: 30,
              color: Color(0xffFD3030).withOpacity(0.7),
              onPressed: () {
                onClose();
              },
            ),
          ),
        ],
      ),
    );
  }
}
