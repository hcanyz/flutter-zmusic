import 'package:flutter/material.dart';

import '_login_phone.dart';
import '_main.dart';

const String _route_login_main = '/login/main';

const String _route_login_phone_check = '/login/phone_check';

const String _route_login_phone_password = '/login/phone_pwd';

const String _route_login_phone_sms = '/login/phone_sms';

const String _route_login_phone_register = '/login/phone_register';

void skipLoginMain(BuildContext context) {
  Navigator.popAndPushNamed(context, _route_login_main);
}

void skipLoginPhoneCheck(BuildContext context) {
  Navigator.pushNamed(context, _route_login_phone_check);
}

void skipLoginPhonePassword(
    BuildContext context, String phoneNum, String countryCode) {
  Navigator.pushNamed(context, _route_login_phone_password,
      arguments: {'phoneNum': phoneNum, 'countryCode': countryCode});
}

void skipLoginPhoneSms(
    BuildContext context, String phoneNum, String countryCode) {
  Navigator.pushNamed(context, _route_login_phone_sms,
      arguments: {'phoneNum': phoneNum, 'countryCode': countryCode});
}

void skipLoginRegister(BuildContext context, String phoneNum, String captcha) {
  Navigator.pushNamed(context, _route_login_phone_register,
      arguments: {'phoneNum': phoneNum, 'captcha': captcha});
}

Route<dynamic> generateRouteLogin(RouteSettings settings) {
  switch (settings.name) {
    case _route_login_main:
      return PageRouteBuilder(
          settings: settings,
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              LoginMain());
    case _route_login_phone_check:
      return PageRouteBuilder(
          settings: settings,
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              PhoneCheck());
    case _route_login_phone_password:
      var arguments = settings.arguments as Map;
      return PageRouteBuilder(
          settings: settings,
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              PhoneLoginPassword(
                  arguments['phoneNum'] ?? '', arguments['countryCode'] ?? ''));
    case _route_login_phone_sms:
      var arguments = settings.arguments as Map;
      return PageRouteBuilder(
          settings: settings,
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              PhoneLoginSms(
                  arguments['phoneNum'] ?? '', arguments['countryCode'] ?? ''));
    case _route_login_phone_register:
      var arguments = settings.arguments as Map;
      return PageRouteBuilder(
          settings: settings,
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              PhoneLoginRegister(
                  arguments['phoneNum'] ?? '', arguments['captcha'] ?? ''));
  }
  return null;
}
