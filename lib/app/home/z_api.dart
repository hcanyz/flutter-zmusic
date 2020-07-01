import 'package:flutter/material.dart';

import '_main.dart';

const String _route_home_main = '/home/main';

void skipHomeMainSingleTask(BuildContext context) {
  Navigator.pushNamedAndRemoveUntil(
      context, _route_home_main, (route) => false);
}

Route<dynamic> generateRouteMain(RouteSettings settings) {
  switch (settings.name) {
    case _route_home_main:
      return PageRouteBuilder(
          settings: settings,
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              HomeMain());
  }
  return null;
}
