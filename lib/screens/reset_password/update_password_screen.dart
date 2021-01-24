import 'package:flutter/material.dart';
import 'package:gala_sejahtera/models/auth_credentials.dart';
import 'package:gala_sejahtera/services/rest_api_services.dart';
import 'package:gala_sejahtera/widgets/custom_field.dart';
import 'package:gala_sejahtera/widgets/rounded_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:sweetalert/sweetalert.dart';

class UpdatePasswordScreen extends StatefulWidget {
  static const String id = 'update_password_screen';

  @override
  _UpdatePasswordScreenState createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  bool showSpinner = false;
  String password;
  String passwordErrorMessage = '';
  bool passwordError = false;

  RestApiServices restApiServices = RestApiServices();

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

  void updatePassword() async {
    String id = Provider.of<AuthCredentials>(context, listen: false).id;
    var respond =
        await restApiServices.passwordUpdate(id: id, password: password);
    if (respond != null) {
      SweetAlert.show(
        context,
        subtitle: 'Password has been changed.',
      );
    } else
      SweetAlert.show(
        context,
        subtitle: 'Error occurs.',
      );
    setState(() {
      showSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff60A1DD),
      appBar: AppBar(
        title: Text(
          'Update Password',
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
                error: passwordError,
                errorMessage: passwordErrorMessage,
                onChanged: (value) {
                  validatePassword(value);
                  password = value;
                },
                hintText: 'Enter new password',
                obscureText: true,
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Update Password',
                color: Colors.lightBlueAccent,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  updatePassword();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
