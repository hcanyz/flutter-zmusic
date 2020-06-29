import 'package:flutter/material.dart';

import '_login_phone.dart';
import '_main.dart';

const String route_login_main = '/login/main';

const String route_login_phone_check = '/login/phone_check';

const String _route_login_phone_password = '/login/phone_pwd';

const String _route_login_phone_sms = '/login/phone_sms';

const String _route_login_phone_register = '/login/phone_register';

void skipLoginPhonePassword(BuildContext context, String phoneNum) {
  Navigator.pushNamed(context, _route_login_phone_password,
      arguments: {'phoneNum': phoneNum});
}

void skipLoginPhoneSms(BuildContext context, String phoneNum) {
  Navigator.pushNamed(context, _route_login_phone_sms,
      arguments: {'phoneNum': phoneNum});
}

void skipLoginRegister(BuildContext context, String phoneNum) {
  Navigator.pushNamed(context, _route_login_phone_register,
      arguments: {'phoneNum': phoneNum});
}

Route<dynamic> generateRouteLogin(RouteSettings settings) {
  switch (settings.name) {
    case route_login_main:
      return PageRouteBuilder(
          settings: settings,
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              LoginMain());
    case route_login_phone_check:
      return PageRouteBuilder(
          settings: settings,
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              PhoneCheck());
    case _route_login_phone_password:
      return PageRouteBuilder(
          settings: settings,
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              PhoneLoginPassword(
                  (settings.arguments as Map)['phoneNum'] ?? ''));
    case _route_login_phone_sms:
      return PageRouteBuilder(
          settings: settings,
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              PhoneLoginSms((settings.arguments as Map)['phoneNum'] ?? ''));
    case _route_login_phone_register:
      return PageRouteBuilder(
          settings: settings,
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              PhoneLoginRegister(
                  (settings.arguments as Map)['phoneNum'] ?? ''));
  }
  return null;
}
