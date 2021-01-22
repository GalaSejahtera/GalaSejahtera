import 'package:flutter/material.dart';

const API_BASE_URL = "http://galasejahtera.duckdns.org/";

/// Text field styling. Check register/login screen
var kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: InputBorder.none,
  focusedBorder: InputBorder.none,
  enabledBorder: InputBorder.none,
  errorBorder: InputBorder.none,
  disabledBorder: InputBorder.none,
);

class ApiEndpoints {
  static const GET_COVID_NEWS = "v1/covids";
  static const CREATE_USER_ACCOUNT = "v1/users/0";
}