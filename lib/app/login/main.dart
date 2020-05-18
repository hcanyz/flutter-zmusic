import 'package:flutter/material.dart';
import 'package:zmusic/app/common/res.dart';

class LoginMain extends StatefulWidget {
  @override
  _LoginMainState createState() => _LoginMainState();
}

class _LoginMainState extends State<LoginMain> {
  @override
  void initState() {
    super.initState();
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
              joinImageAssetPath('', 'logo_circle.png'),
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
                  onPressed: () {},
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
                    onPressed: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 27.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 32.0),
                        child: Image.asset(
                          joinImageAssetPath('', 'logo_circle.png'),
                          width: 31,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 32.0),
                        child: Image.asset(
                          joinImageAssetPath('', 'logo_circle.png'),
                          width: 31,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 32.0),
                        child: Image.asset(
                          joinImageAssetPath('', 'logo_circle.png'),
                          width: 31,
                        ),
                      ),
                      Image.asset(
                        joinImageAssetPath('', 'logo_circle.png'),
                        width: 31,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    children: [
                      Checkbox(
                        value: true,
                        activeColor: zmusic_secondary_color,
                        onChanged: (v) {},
                      ),
                      Text(
                        '同意《用户协议》《隐私政策》《儿童隐私政策》',
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
