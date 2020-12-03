import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Icon icon;
  final Function onPressed;
  final String title;
  final bool active;

  const CustomIconButton(
      {this.icon, this.onPressed, this.title = "", this.active = false});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Material(
        elevation: 5.0,
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(50.0),
        child: Ink(
          width: 60,
          height: 60,
          decoration: ShapeDecoration(
            color: active ? Color(0xffFD3030) : Color(0xfffa7070),
            shape: CircleBorder(),
          ),
          child: IconButton(
            icon: icon,
            iconSize: 40,
            color: Colors.white,
            onPressed: onPressed,
          ),
        ),
      ),
      if (title != "")
        SizedBox(
          height: 5,
        ),
      if (title != "") Text(title)
    ]);
  }
}
