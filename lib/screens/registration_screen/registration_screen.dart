import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gala_sejahtera/models/auth_credentials.dart';
import 'package:gala_sejahtera/screens/nav_bar/nav_bar.dart';
import 'package:gala_sejahtera/widgets/custom_field.dart';
import 'package:gala_sejahtera/services/rest_api_services.dart';
import 'package:gala_sejahtera/widgets/rounded_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  RestApiServices restApiServices = RestApiServices();

  String email;
  String emailErrorMessage = '';
  bool emailError = false;

  String fullName;
  String fullNameErrorMessage = '';
  bool fullNameError = false;

  String username;
  String usernameErrorMessage = '';
  bool usernameError = false;

  String password;
  String passwordErrorMessage = '';
  bool passwordError = false;

  bool showSpinner = false;

  void validateEmail(String value) {
    setState(() {
      //check if valid email format (xxx@xxx.x)
      if (!RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value)) {
        emailError = true;
        emailErrorMessage = 'Email is not valid';
      } else {
        emailError = false;
        emailErrorMessage = '';
      }
    });
  }

  void validateFullName(String value) {
    setState(() {
      if (value.isEmpty) {
        fullNameError = true;
        fullNameErrorMessage = 'Full Name is empty';
      } else if (value.length < 6) {
        fullNameError = true;
        fullNameErrorMessage = 'Full Name is less than 6';
      } else {
        fullNameError = false;
        fullNameErrorMessage = '';
      }
    });
  }

  void validateUsername(String value) {
    setState(() {
      if (value.isEmpty) {
        usernameError = true;
        usernameErrorMessage = 'Username is empty';
      } else if (value.length < 6) {
        usernameError = true;
        usernameErrorMessage = 'Username is less than 6';
      } else {
        usernameError = false;
        usernameErrorMessage = '';
      }
    });
  }

  void validatePassword(String value) {
    setState(() {
      if (value.isEmpty) {
        passwordError = true;
        passwordErrorMessage = 'Password is empty';
      } else if (value.length < 6) {
        passwordError = true;
        passwordErrorMessage = 'Password is less than 6';
      } else {
        passwordError = false;
        passwordErrorMessage = '';
      }
    });
  }

  void registerUser() async {
    Response response = await restApiServices.registerUser(
        username: username, email: email, password: password);
    // registration success
    if (response != null) {
      // call login api to immediately login the user
      AuthCredentials ac =
          await restApiServices.userLogin(email: email, password: password);
      Provider.of<AuthCredentials>(context, listen: false)
          .createNewCredentials(ac);

      // navigate
      Navigator.pushNamed(context, NavBar.id);
      return;
    }

    print('Registration Error');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Color(0xff60A1DD),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 60.0,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              CustomField(
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                error: emailError,
                errorMessage: emailErrorMessage,
                onChanged: (value) {
                  validateEmail(value);
                  email = value;
                },
                hintText: 'Email',
              ),
              SizedBox(
                height: 8.0,
              ),
              CustomField(
                error: fullNameError,
                errorMessage: fullNameErrorMessage,
                onChanged: (value) {
                  validateFullName(value);
                  fullName = value;
                },
                hintText: 'Full name',
              ),
              SizedBox(
                height: 8.0,
              ),
              CustomField(
                error: usernameError,
                errorMessage: usernameErrorMessage,
                onChanged: (value) {
                  validateUsername(value);
                  username = value;
                },
                hintText: 'Username',
              ),
              SizedBox(
                height: 8.0,
              ),
              CustomField(
                error: passwordError,
                errorMessage: passwordErrorMessage,
                onChanged: (value) {
                  validatePassword(value);
                  password = value;
                },
                hintText: 'Password',
                obscureText: true,
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Register',
                color: Colors.blueAccent,
                onPressed: () {
                  setState(() {
                    showSpinner = true;
                  });
                  registerUser();
                  setState(() {
                    showSpinner = false;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
