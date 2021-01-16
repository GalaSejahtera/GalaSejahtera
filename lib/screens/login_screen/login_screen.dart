import 'package:flutter/material.dart';
import 'package:gala_sejahtera/screens/nav_bar/nav_bar.dart';
import 'package:gala_sejahtera/screens/registration_screen/registration_screen.dart';
import 'package:gala_sejahtera/widgets/custom_field.dart';
import 'package:gala_sejahtera/widgets/rounded_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  bool showSpinner = false;

  String email;
  String emailErrorMessage = '';
  bool emailError = false;

  String password;
  String passwordErrorMessage = '';
  bool passwordError = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    animation = ColorTween(begin: Colors.white, end: Color(0xff60A1DD))
        .animate(controller);
    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
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
                error: emailError,
                errorMessage: emailErrorMessage,
                onChanged: (value) {
                  validateEmail(value);
                  email = value;
                },
                hintText: 'Email',
              ),
              SizedBox(
                height: 10.0,
              ),
              CustomField(
                obscureText: true,
                error: passwordError,
                errorMessage: passwordErrorMessage,
                onChanged: (value) {
                  validatePassword(value);
                  password = value;
                },
                hintText: 'Password',
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Login',
                color: Colors.lightBlueAccent,
                onPressed: () {
                  setState(() {
                    showSpinner = true;
                  });
                  Navigator.pushNamed(context, NavBar.id);
                  setState(() {
                    showSpinner = false;
                  });
                },
              ),
              RoundedButton(
                title: 'Register Now',
                color: Colors.blueAccent,
                onPressed: () {
                  setState(() {
                    showSpinner = true;
                  });
                  Navigator.pushNamed(context, RegistrationScreen.id);
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
