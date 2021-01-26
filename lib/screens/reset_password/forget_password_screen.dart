import 'package:flutter/material.dart';
import 'package:gala_sejahtera/services/rest_api_services.dart';
import 'package:gala_sejahtera/widgets/custom_field.dart';
import 'package:gala_sejahtera/widgets/rounded_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sweetalert/sweetalert.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const String id = 'forget_password_screen';

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  bool showSpinner = false;
  String email;
  String emailErrorMessage = '';
  bool emailError = false;

  RestApiServices restApiServices = RestApiServices();

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

  void passwordReset() async {
    Map respond = await restApiServices.passwordReset(email: email);
    if (respond != null) {
      SweetAlert.show(
        context,
        subtitle: 'New password has been sent to your email.',
// not usable as cant fit inside sweet alert
//        subtitle: respond['message'],
      );
    } else {
      SweetAlert.show(
        context,
        subtitle: "User not found",
      );
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
          'Forget Password',
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
                height: 24.0,
              ),
              RoundedButton(
                title: 'Reset Password',
                color: Colors.lightBlueAccent,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  passwordReset();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
