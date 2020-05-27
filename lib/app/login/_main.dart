import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zmusic/app/common/res.dart';
import 'package:zmusic/app/home/z_api.dart';

import 'z_api.dart';

class LoginMain extends StatefulWidget {
  @override
  _LoginMainState createState() => _LoginMainState();
}

class _LoginMainState extends State<LoginMain>
    with SingleTickerProviderStateMixin {
  bool _protocolChecked = false;

  AnimationController _protocolAnimationController;

  @override
  void initState() {
    super.initState();
    _protocolAnimationController =
        AnimationController(duration: Duration(milliseconds: 100), vsync: this);
  }

  @override
  void dispose() {
    _protocolAnimationController.dispose();
    super.dispose();
  }

  void _checkSignProtocol(Function call) {
    if (_protocolChecked) {
      call();
      return;
    }
    _protocolAnimationController.repeat();
    Future.delayed(Duration(milliseconds: 233))
        .whenComplete(() => _protocolAnimationController.stop());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(alignment: Alignment.topCenter, children: [
          Positioned(
            top: 216 - MediaQuery.of(context).padding.top,
            child: Image.asset(
              joinImageAssetPath('logo_circle.png'),
              width: 72,
            ),
          ),
          Positioned(
            bottom: 30,
            child: Column(
              children: [
                MaterialButton(
                  child: Text(
                    '手机号登录',
                    style:
                        TextStyle(color: zmusic_secondary_color, fontSize: 16),
                  ),
                  minWidth: 260,
                  height: 39,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  elevation: 0,
                  onPressed: () => _checkSignProtocol(
                      () => Navigator.pushNamed(context, route_login_phone)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: MaterialButton(
                    child: Text(
                      '立即体验',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    minWidth: 260,
                    height: 39,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: zmusic_secondary_color),
                        borderRadius: BorderRadius.circular(20.0)),
                    elevation: 0,
                    onPressed: () => _checkSignProtocol(
                        () => Navigator.pushNamed(context, route_home_main)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 27.0),
                  child: Row(
                    children: [
                      buildThirdLogin(
                          joinImageAssetPath('login_bywx.png', 'login'), () {}),
                      buildThirdLogin(
                          joinImageAssetPath('login_byqq.png', 'login'), () {}),
                      buildThirdLogin(
                          joinImageAssetPath('login_bywb.png', 'login'), () {}),
                      buildThirdLogin(
                          joinImageAssetPath('login_byemail.png', 'login'),
                          () {},
                          padding: false)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: SlideTransition(
                    position: new Tween(
                      begin: Offset(0.0, 0.0),
                      end: Offset(0.05, 0.0),
                    ).animate(_protocolAnimationController),
                    child: Row(
                      children: [
                        Transform.scale(
                          scale: 0.5,
                          transformHitTests: false,
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: Checkbox(
                              value: _protocolChecked,
                              activeColor: zmusic_secondary_color,
                              onChanged: (bool value) {
                                setState(() {
                                  _protocolChecked = !_protocolChecked;
                                });
                              },
                            ),
                          ),
                        ),
                        Text(
                          '同意《用户协议》《隐私政策》《儿童隐私政策》',
                          style: TextStyle(color: Colors.white, fontSize: 11),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }

  Widget buildThirdLogin(String icon, GestureTapCallback onTap,
      {bool padding = true}) {
    final c = GestureDetector(
      onTap: () {
        _checkSignProtocol(onTap);
      },
      child: Image.asset(
        icon,
        width: 31,
      ),
    );
    if (!padding) {
      return c;
    }
    return Padding(
      padding: const EdgeInsets.only(right: 32.0),
      child: c,
    );
  }
}
