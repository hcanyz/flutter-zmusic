import 'package:flutter/material.dart';

import 'app/login/z_api.dart';
import 'app/splash/z_api.dart';

const String initialRoute = route_splash_main;

Route<dynamic> configRouters(RouteSettings settings) {
  List<RouteFactory> factorys = [generateRouteSplash, generateRouteLogin];
  for (var factory in factorys) {
    var route = factory(settings);
    if (route != null) {
      return route;
    }
  }
  return null;
}
