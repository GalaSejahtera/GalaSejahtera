import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Icon icon;
  final Function onPressed;
  final String title;

  const CustomIconButton({this.icon, this.onPressed, this.title = ""});

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
          decoration: const ShapeDecoration(
            color: Color(0xffFD3030),
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
