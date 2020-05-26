import 'package:flutter/material.dart';

import '_login_phone.dart';
import '_main.dart';

const String route_login_main = '/login/main';

const String route_login_phone = '/login/phone';

Route<dynamic> generateRouteLogin(RouteSettings settings) {
  switch (settings.name) {
    case route_login_main:
      return PageRouteBuilder(
          settings: settings,
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              LoginMain());
    case route_login_phone:
      return PageRouteBuilder(
          settings: settings,
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              PhoneLogin());
  }
  return null;
}
