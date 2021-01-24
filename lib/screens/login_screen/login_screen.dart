import 'package:flutter/material.dart';
import 'package:gala_sejahtera/models/auth_credentials.dart';
import 'package:gala_sejahtera/screens/nav_bar/nav_bar.dart';
import 'package:gala_sejahtera/screens/registration_screen/registration_screen.dart';
import 'package:gala_sejahtera/screens/reset_password/forget_password_screen.dart';
import 'package:gala_sejahtera/services/rest_api_services.dart';
import 'package:gala_sejahtera/utils/constants.dart';
import 'package:gala_sejahtera/widgets/custom_field.dart';
import 'package:gala_sejahtera/widgets/rounded_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:sweetalert/sweetalert.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  RestApiServices restApiServices = RestApiServices();

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

  void loginUser() async {
    Map userDetails =
    await restApiServices.userLogin(email: email, password: password);

    if (!userDetails.containsKey(ApiResponseKey.error)) {
      // save auth details in state
      Provider.of<AuthCredentials>(context, listen: false)
          .createNewCredentials(AuthCredentials.fromJson(userDetails));
      //navigate

      Navigator.pushNamed(context, NavBar.id);
    } else {
      SweetAlert.show(
        context,
        subtitle: userDetails[ApiResponseKey.message],
      );
    }

    setState(() {
      showSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
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
                    height: 150.0,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
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
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  loginUser();
                },
              ),
              RoundedButton(
                title: 'Register Now',
                color: Colors.blueAccent,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  Navigator.pushNamed(context, RegistrationScreen.id);
                  setState(() {
                    showSpinner = false;
                  });
                },
              ),
              SizedBox(
                height: 13.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ForgetPasswordScreen.id);
                },
                child: Text(
                  'Forget Password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
