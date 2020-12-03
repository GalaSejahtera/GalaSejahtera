import 'package:flutter/material.dart';
import 'package:gala_sejahtera/screens/home/home_screen.dart';
import 'package:gala_sejahtera/widgets/custom_field.dart';
import 'package:gala_sejahtera/widgets/rounded_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email;
  String fullName;
  String username;
  String password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    height: 200.0,
                    child: Image.asset('assets/images/logo-my-sejahtera.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              CustomField(
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                onChanged: (value) {
                  email = value;
                },
                hintText: 'Email',
              ),
              SizedBox(
                height: 8.0,
              ),
              CustomField(
                onChanged: (value) {
                  fullName = value;
                },
                hintText: 'Full name',
              ),
              SizedBox(
                height: 8.0,
              ),
              CustomField(
                onChanged: (value) {
                  username = value;
                },
                hintText: 'Username',
              ),
              SizedBox(
                height: 8.0,
              ),
              CustomField(
                onChanged: (value) {
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
                  Navigator.pushNamed(context, HomeScreen.id);
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
