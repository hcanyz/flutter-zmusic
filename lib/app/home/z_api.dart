import 'package:flutter/material.dart';

import '_main.dart';

const String route_home_main = '/home/main';

Route<dynamic> generateRouteMain(RouteSettings settings) {
  switch (settings.name) {
    case route_home_main:
      return PageRouteBuilder(
          settings: settings,
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              HomeMain());
  }
  return null;
}
