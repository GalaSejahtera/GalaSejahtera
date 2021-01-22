import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gala_sejahtera/models/auth_credentials.dart';
import 'package:gala_sejahtera/screens/login_screen/login_screen.dart';
import 'package:gala_sejahtera/widgets/custom_autocomplete.dart';
import 'package:gala_sejahtera/widgets/display_box.dart';
import 'package:gala_sejahtera/widgets/rounded_button.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selected = "";

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(children: <Widget>[
            DisplayBox(
              title: '10',
              description: "Nearby Symptomatic Users",
            ),
            DisplayBox(
              title: '2000',
              description: "Covid-19 Cases in Your District",
            ),
          ]),
          Container(
            height: 250,
            width: double.infinity,
            margin: EdgeInsets.all(10),
            child: Material(
              elevation: 5.0,
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(30.0),
              child: Center(
                child: Text(
                  'Graph showing here',
                  style: TextStyle(
                    color: Color(0xffFD3030).withOpacity(0.7),
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: CustomAutocomplete(
                typeAheadController: controller,
                onChanged: (value) {
                  setState(() {
                    selected = value;
                    controller.text = value;
                  });
                },
                hintText: 'Search for district',
                suggestions: ["Kuala Lumpur", "Selangor", "Johor"]),
          ),
          Text(
            //example to get the state from Provider
            'ACCESS TOKEN: ${Provider.of<AuthCredentials>(context).accessToken}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 9.0,
            ),
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: RoundedButton(
                title: 'Login For More Features',
                color: Colors.black,
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
