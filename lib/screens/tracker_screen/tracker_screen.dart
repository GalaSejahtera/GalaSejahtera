import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gala_sejahtera/models/auth_credentials.dart';
import 'package:gala_sejahtera/services/rest_api_services.dart';
import 'package:gala_sejahtera/utils/constants.dart';
import 'package:gala_sejahtera/utils/notification_helper.dart';
import 'package:gala_sejahtera/widgets/custom_autocomplete.dart';
import 'package:gala_sejahtera/widgets/custom_iconbutton.dart';
import 'package:gala_sejahtera/widgets/display_box.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

class TrackerScreen extends StatefulWidget {
  @override
  _TrackerScreenState createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  RestApiServices restApiServices = RestApiServices();
  TextEditingController controller = TextEditingController();

  bool trackLocation = false;
  String myDistrictCases = "0";
  String selected = "";
  String districtCaseNumber = "";
  String nearbySymptomaticUsers = "0";
  List<String> districtList = MALAYSIA_DISTRICTS;

  LocationPermission permission;
  bool isLocationServiceEnabled;
  StreamSubscription<Position> locationSubscriber;

  @override
  void initState() {
    super.initState();
    initNotification();
  }

  // request for location permission and check if user enable location service
  void checkLocationPermission() async {
    // device location service
    isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

     // app permission to access location
    permission = await Geolocator.checkPermission();

    // check if location service is disabled
    if (!isLocationServiceEnabled) {
      setState(() {
        trackLocation = false;
      });

      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Please turn on location service!"),
        backgroundColor: Color(0xFFFF0000),
      ));
    }

    // handle location disabled forever (never ask again)
    if (permission == LocationPermission.deniedForever) {
      setState(() {
        trackLocation = false;
      });

      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Please allow the application to access location!"),
        backgroundColor: Color(0xFFFF0000),
      ));
    }

    // permission to access location is denied, request for the permission
    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      permission = await Geolocator.requestPermission();
    }

    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      setState(() {
        trackLocation = false;
      });
    }

    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("Enabled Location Tracking"),
      backgroundColor: Color(0xFF0000FF),
    ));
  }

  // track the user location continuously
  void trackUserLocation(token, userId) async {
    if (trackLocation) {
      // update location every 60 seconds
      locationSubscriber = Geolocator.getPositionStream(
              desiredAccuracy: LocationAccuracy.high,
              intervalDuration: new Duration(seconds: 60))
          .listen((Position position) async {
        // check for user current district
        getMyDistrictCases(token, position.latitude, position.longitude);

        // get the symtoptic nearby users
        int symptomaticUser = await getNearbyUser(
            token, userId, position.latitude, position.longitude);
          
        
          setState(() {
            nearbySymptomaticUsers = symptomaticUser.toString();
          });

        // if there is symptomatic user, show notification
        if (symptomaticUser > 0) {
          showNotification("Symptomatic User(s) Nearby!",
              "Watch out! $symptomaticUser user(s) around you. Please practice social distancing!");
        }
      });

      return;
    }

    if (locationSubscriber != null) {
      locationSubscriber.cancel();
      locationSubscriber = null;
    }
  }

  // get nearby users
  Future<int> getNearbyUser(
      String token, String userId, double latitude, double longitude) async {
    Map nearbyUsers = await restApiServices.getNearbyUsers(
        token, userId, latitude, longitude);

    return int.parse(nearbyUsers['userNum']);
  }

  // get the user current location's district and get the number of cases in the user's district
  void getMyDistrictCases(
      String token, double latitude, double longitude) async {
    // get the user district using latitude and longitude
    Map myLocation =
        await restApiServices.reverseGeocoding(latitude, longitude);
    String myDistrict = myLocation['address']['county'];

    if (myDistrict == null) {
      myDistrict = myLocation['address']['region'];
    }

    if (myDistrict == null) {
      myDistrict = myLocation['address']['city'];
    }

    // remap
    for (var district in MALAYSIA_DISTRICTS) {
      if (myDistrict.contains(district)) {
        myDistrict = district;

        break;
      }
    }

    // get number of cases based on the user district
    Map response = await restApiServices.getCaseByDistrict(token, myDistrict);
    setState(() {
      myDistrictCases = response['total'];
    });
  }

  // get the number of cases based on the search district
  void searchDistrictCases(token, district) async {
    Map response = await restApiServices.getCaseByDistrict(token, district);

    setState(() {
      districtCaseNumber = response['total'];
    });
  }

  @override
  Widget build(BuildContext context) {
    String token = Provider.of<AuthCredentials>(context).accessToken;
    String userId = Provider.of<AuthCredentials>(context).id;

    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only(top: 40),
      child: Stack(fit: StackFit.expand, children: <Widget>[
        InteractiveViewer(
          panEnabled: true,
          boundaryMargin: EdgeInsets.all(20),
          minScale: 0.5,
          maxScale: 3.0,
          child: SvgPicture.asset('assets/images/malaysia.svg',
              semanticsLabel: 'Malaysia Map'),
        ),
        Positioned(
          bottom: 30,
          right: 35,
          child: CustomIconButton(
              title: "Track Location",
              icon: Icon(Icons.power_settings_new),
              active: trackLocation,
              onPressed: () {
                setState(() {
                  trackLocation = !trackLocation;
                });

                if (!trackLocation) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Disabled Location Tracking"),
                  ));
                } else {
                  checkLocationPermission();
                }

                trackUserLocation(token, userId);
              }),
        ),
        Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: CustomAutocomplete(
                  typeAheadController: controller,
                  onChanged: (value) {
                    searchDistrictCases(token, value);
                    setState(() {
                      selected = value;
                      controller.text = value;
                    });
                  },
                  hintText: 'Search for district',
                  suggestions: districtList),
            ),
            Row(children: <Widget>[
              DisplayBox(
                title: nearbySymptomaticUsers,
                description: "Nearby Symptomatic Users",
              ),
              DisplayBox(
                title: myDistrictCases,
                description: "Covid-19 Cases in Your District",
              ),
            ]),
            if (selected != "")
              Row(children: <Widget>[
                DisplayBox(
                  title: districtCaseNumber,
                  description: 'Covid-19 Cases in $selected',
                  hasClose: true,
                  onClose: () {
                    setState(() {
                      selected = "";
                    });
                  },
                ),
              ]),
          ],
        ),
      ]),
    );
  }
}
