import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zmusic/common/res.dart';

class PhoneLogin extends StatefulWidget {
  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('手机号登录'),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '未注册手机号登录后将自动创建帐号',
              style: const TextStyle(color: color_text_secondary),
            ),
            Container(
              margin: const EdgeInsets.only(top: 28),
              child: TextField(
                autofocus: true,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    prefix: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '+86',
                          style: TextStyle(color: color_text_primary),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: color_text_primary,
                        )
                      ],
                    ),
                    hintText: '请输入手机号',
                    hintStyle: TextStyle(color: color_text_hint)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 37),
              child: MaterialButton(
                child: Text(
                  '下一步',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                minWidth: double.infinity,
                height: 39,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                color: color_secondary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                elevation: 0,
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
