import 'package:flutter/material.dart';
import 'package:zmusic/app/splash/main.dart';

const String route_splash_main = '/splash/main';

Route<dynamic> generateRouteSplash(RouteSettings settings) {
  switch (settings.name) {
    case route_splash_main:
      return PageRouteBuilder(
          settings: settings,
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              SplashMain());
  }
  return null;
}
