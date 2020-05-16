import 'package:flutter/material.dart';

import 'main.dart';

const String route_login_main = '/login/main';

Route<dynamic> generateRouteLogin(RouteSettings settings) {
  switch (settings.name) {
    case route_login_main:
      return PageRouteBuilder(
          settings: settings,
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              LoginMain());
  }
  return null;
}
