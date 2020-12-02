import 'package:flutter/material.dart';
import 'package:gala_sejahtera/utils/constants.dart';

class CustomField extends StatelessWidget {
  final bool obscureText;
  final Function onChanged;
  final String hintText;
  final TextInputType keyboardType;

  const CustomField(
      {this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.onChanged,
      this.hintText});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      color: Colors.white.withOpacity(0.7),
      borderRadius: BorderRadius.circular(10.0),
      child: TextField(
        keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: onChanged,
        decoration: kTextFieldDecoration.copyWith(hintText: hintText),
      ),
    );
  }
}
