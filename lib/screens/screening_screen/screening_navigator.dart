import 'package:flutter/material.dart';
import 'package:gala_sejahtera/screens/screening_screen/screening_screen.dart';
import 'take_assessment_screen.dart';
import 'assessment_history.dart';
import 'result.dart';
import 'history_details.dart';

class ScreeningNavigator extends StatefulWidget {
  @override
  _ScreeningNavigatorState createState() => _ScreeningNavigatorState();
}

class _ScreeningNavigatorState extends State<ScreeningNavigator> {
  GlobalKey<NavigatorState> _screeningNavigatorKey =
      GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _screeningNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            switch (settings.name) {
              case '/':
                return ScreeningScreen();
              case '/Assessment':
                return TakeAssessmentScreen();
              case '/Result':
                return ResultScreen();
              case '/AssessmentHistory':
                return AssessmentHistoryScreen();
              case '/HistoryDetails':
                return HistoryDetailsScreen();
            }
          },
        );
      },
    );
  }
}
