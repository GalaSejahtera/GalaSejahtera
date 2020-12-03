import 'package:flutter/material.dart';

class DisplayBox extends StatelessWidget {
  final String title;
  final String description;
  final bool hasClose;
  final Function onClose;

  const DisplayBox(
      {this.title, this.description, this.hasClose = false, this.onClose});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Stack(
        children: [
          Container(
            height: 140,
            margin: EdgeInsets.all(10),
            child: Material(
              elevation: 5.0,
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(30.0),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                        color: Color(0xffFD3030).withOpacity(0.7),
                        fontSize: 40,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (hasClose)
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
