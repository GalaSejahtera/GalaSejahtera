import 'package:flutter/material.dart';
import 'package:gala_sejahtera/screens/news_screen/news_details_screen.dart';
import 'package:gala_sejahtera/screens/news_screen/news_layout_screen.dart';

class NewsNavigator extends StatefulWidget {
  @override
  _NewsNavigatorState createState() => _NewsNavigatorState();
}

class _NewsNavigatorState extends State<NewsNavigator> {
  GlobalKey<NavigatorState> _newsNavigatorKey =
  GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _newsNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            switch (settings.name) {
              case '/':
                return NewsLayoutScreen();
              case '/NewsDetail':
                return NewsDetailScreen();
            }
          },
        );
      },
    );
  }
}