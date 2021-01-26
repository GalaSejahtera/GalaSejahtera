import 'package:flutter/material.dart';
import 'package:gala_sejahtera/models/auth_credentials.dart';
import 'package:gala_sejahtera/screens/nav_bar/nav_bar.dart';
import 'package:gala_sejahtera/services/rest_api_services.dart';
import 'package:gala_sejahtera/utils/constants.dart';
import 'package:gala_sejahtera/widgets/custom_field.dart';
import 'package:gala_sejahtera/widgets/rounded_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:sweetalert/sweetalert.dart';

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
    Map response =
        await restApiServices.createUserAccount(username, email, password);
    // registration success
    if (!response.containsKey(ApiResponseKey.error)) {
      // call login api to immediately login the user
      Map userDetails =
          await restApiServices.userLogin(email: email, password: password);
      Provider.of<AuthCredentials>(context, listen: false)
          .createNewCredentials(AuthCredentials.fromJson(userDetails));

      // navigate
      Navigator.pushNamed(context, NavBar.id);
    } else {
      SweetAlert.show(context, subtitle: response['error']);
    }

    setState(() {
      showSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Register',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
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
                height: 30.0,
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
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
