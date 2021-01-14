import 'package:flutter/material.dart';
import 'package:gala_sejahtera/utils/constants.dart';

class CustomField extends StatefulWidget {
  final bool obscureText;
  final Function onChanged;
  final String hintText;
  final TextInputType keyboardType;
  final bool error;
  final String errorMessage;

  const CustomField({
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.onChanged,
    this.hintText,
    this.error = false,
    this.errorMessage = '',
  });

  @override
  CustomFieldState createState() => CustomFieldState();
}

class CustomFieldState extends State<CustomField> {
  @override
  Widget build(BuildContext context) {
    bool error = widget.error;
    return Column(
      children: [
        Material(
          elevation: 5.0,
          color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(10.0),
          child: TextField(
            keyboardType: widget.keyboardType,
            obscureText: widget.obscureText,
            onChanged: widget.onChanged,
            decoration: kTextFieldDecoration.copyWith(
              hintText: widget.hintText,
              focusedBorder: error
                  ? OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    )
                  : OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white.withOpacity(0.7), width: 0.5),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
              enabledBorder: error
                  ? OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    )
                  : OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white.withOpacity(0.7), width: 0.5),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Text(
            widget.errorMessage,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
