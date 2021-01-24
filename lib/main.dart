import 'package:flutter/material.dart';
import 'package:gala_sejahtera/models/auth_credentials.dart';
import 'package:gala_sejahtera/screens/login_screen/login_screen.dart';
import 'package:gala_sejahtera/screens/nav_bar/nav_bar.dart';
import 'package:gala_sejahtera/screens/registration_screen/registration_screen.dart';
import 'package:gala_sejahtera/screens/reset_password/forget_password_screen.dart';
import 'package:gala_sejahtera/screens/reset_password/update_password_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(GalaSejahtera());
}

class GalaSejahtera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AuthCredentials(),
        child: MaterialApp(initialRoute: NavBar.id, routes: {
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          ForgetPasswordScreen.id: (context) => ForgetPasswordScreen(),
          UpdatePasswordScreen.id: (context) => UpdatePasswordScreen(),
          NavBar.id: (context) => NavBar(),
          //other screens
        }));
  }
}
