import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zmusic/app/common/res.dart';
import 'package:zmusic/app/login/z_api.dart';

class SplashMain extends StatefulWidget {
  @override
  _SplashMainState createState() => _SplashMainState();
}

class _SplashMainState extends State<SplashMain> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context);
      Navigator.pushNamed(context, route_login_main);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: 200,
              child: Image.asset(
                joinImageAssetPath('splash_decoration.png', 'splash'),
                width: 212,
              ),
            ),
            Positioned(
              child: Image.asset(
                  joinImageAssetPath('splash_decoration_2.png', 'splash')),
              width: 94,
              bottom: 20,
            )
          ],
        ),
      ),
    );
  }
}
