import 'package:flutter/material.dart';
import 'package:zmusic/app/home/z_api.dart';
import 'package:zmusic/common/res.dart';
import 'package:zmusic/common/toast_ext.dart';

import 'z_api.dart';

class LoginMain extends StatefulWidget {
  @override
  _LoginMainState createState() => _LoginMainState();
}

class _LoginMainState extends State<LoginMain>
    with SingleTickerProviderStateMixin {
  bool _protocolChecked = false;

  Animation _protocolAnimation;
  AnimationController _protocolAnimationController;

  @override
  void initState() {
    super.initState();
    _protocolAnimationController =
        AnimationController(duration: Duration(milliseconds: 100), vsync: this);
    _protocolAnimation = Tween(
      begin: Offset(-0.015, 0.0),
      end: Offset(0.015, 0.0),
    ).animate(_protocolAnimationController);
  }

  @override
  void dispose() {
    _protocolAnimationController.dispose();
    super.dispose();
  }

  void _checkSignProtocol(VoidCallback call) {
    if (_protocolChecked) {
      call();
      return;
    }
    BotToastExt.showText(text: "请先勾选同意《用户协议》 《隐私政策》 《儿童隐私政策》");
    _doProtocolAnimation(2);
  }

  void _doProtocolAnimation(int count) {
    if (count <= 0) {
      return;
    }
    _protocolAnimationController.forward().whenComplete(() {
      _protocolAnimationController
          .reverse()
          .whenComplete(() => _doProtocolAnimation(count - 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        brightness: Brightness.dark,
      ),
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
                    style: TextStyle(color: color_secondary, fontSize: 16),
                  ),
                  minWidth: 260,
                  height: 39,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  elevation: 0,
                  onPressed: () =>
                      _checkSignProtocol(() => skipLoginPhoneCheck(context)),
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
                        side: BorderSide(color: color_secondary),
                        borderRadius: BorderRadius.circular(20.0)),
                    elevation: 0,
                    onPressed: () => _checkSignProtocol(
                        () => skipHomeMainSingleTask(context)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 27.0),
                  child: Row(
                    children: [
                      _buildThirdLogin(
                          joinImageAssetPath('login_bywx.png', 'login'), () {}),
                      _buildThirdLogin(
                          joinImageAssetPath('login_byqq.png', 'login'), () {}),
                      _buildThirdLogin(
                          joinImageAssetPath('login_bywb.png', 'login'), () {}),
                      _buildThirdLogin(
                          joinImageAssetPath('login_byemail.png', 'login'),
                          () {},
                          padding: false)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: SlideTransition(
                    position: _protocolAnimation,
                    child: Row(
                      children: [
                        Transform.scale(
                          scale: 0.5,
                          transformHitTests: false,
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: Checkbox(
                              checkColor: Colors.white54,
                              value: _protocolChecked,
                              activeColor: color_secondary,
                              onChanged: (bool value) {
                                setState(() {
                                  _protocolChecked = !_protocolChecked;
                                });
                              },
                            ),
                          ),
                        ),
                        Text(
                          '同意',
                          style: TextStyle(
                              color: _protocolChecked
                                  ? Colors.white
                                  : Colors.white54,
                              fontSize: 8),
                        ),
                        Text(
                          '《用户协议》 《隐私政策》 《儿童隐私政策》',
                          style: TextStyle(color: Colors.white, fontSize: 8),
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

  Widget _buildThirdLogin(String icon, GestureTapCallback onTap,
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
