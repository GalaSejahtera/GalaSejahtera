import 'package:flutter/material.dart';


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

class ApiResponseKey {
  static String error = "error";
  static String data = "data";
}

const String API_BASE_URL = "http://galasejahtera.duckdns.org/";

const String GET_COVID_NEWS = "v1/covids";
const String CREATE_USER_ACCOUNT = "v1/users/0";
const String USER_LOGIN = "v1/login";
