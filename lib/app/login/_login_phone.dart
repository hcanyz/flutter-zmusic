import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netease_music_api/netease_music_api.dart';
import 'package:zmusic/app/login/z_api.dart';
import 'package:zmusic/common/res.dart';

class PhoneCheck extends StatefulWidget {
  @override
  _PhoneCheckState createState() => _PhoneCheckState();
}

class _PhoneCheckState extends State<PhoneCheck> {
  var _phoneNum = "";

  var _verified = false;

  void _checkPhone() async {
    if (!_phoneNumChange(_phoneNum)) {
      return;
    }
    var result = await NeteaseMusicApi().checkCellPhoneExistence(_phoneNum);
    if (result.code != RET_CODE_OK) {
      return;
    }
    if (result.needUseSms) {
      skipLoginPhoneSms(context, _phoneNum);
    } else {
      skipLoginPhonePassword(context, _phoneNum);
    }
  }

  bool _phoneNumChange(String str) {
    _phoneNum = str;
    var verified = RegExp(r'[1][123456789]\d{9}').hasMatch(_phoneNum);
    if (verified != _verified) {
      setState(() {
        _verified = verified;
      });
    }
    return verified;
  }

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
                onChanged: _phoneNumChange,
                inputFormatters: [LengthLimitingTextInputFormatter(11)],
                decoration: InputDecoration(
                    errorText: _verified ? null : '请输入正确的手机号',
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
                onPressed: _checkPhone,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PhoneLoginPassword extends StatefulWidget {
  final String _phoneNum;

  PhoneLoginPassword(this._phoneNum);

  @override
  _PhoneLoginPasswordState createState() => _PhoneLoginPasswordState();
}

class _PhoneLoginPasswordState extends State<PhoneLoginPassword> {
  var _phonePassword = "";
  var _verified = false;

  void _loginByPassword() async {
    if (!_passwordChange7check(_phonePassword)) {
      return;
    }
    var result = await NeteaseMusicApi()
        .loginCellPhone(widget._phoneNum, _phonePassword);
  }

  bool _passwordChange7check(String str) {
    _phonePassword = str;
    var verified = _phonePassword.length > 0;
    if (verified != _verified) {
      setState(() {
        _verified = verified;
      });
    }
    return verified;
  }

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
            TextField(
              autofocus: true,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              onChanged: _passwordChange7check,
              decoration: InputDecoration(
                  errorText: _verified ? null : '请输入正确的密码',
                  suffixText: '忘记密码？',
                  hintText: '请输入密码',
                  hintStyle: TextStyle(color: color_text_hint)),
            ),
            Container(
              margin: const EdgeInsets.only(top: 37),
              child: MaterialButton(
                child: Text(
                  '登录',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                minWidth: double.infinity,
                height: 39,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                color: color_secondary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                elevation: 0,
                onPressed: _loginByPassword,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PhoneLoginSms extends StatefulWidget {
  final String _phoneNum;

  PhoneLoginSms(this._phoneNum);

  @override
  _PhoneLoginSmsState createState() => _PhoneLoginSmsState();
}

class _PhoneLoginSmsState extends State<PhoneLoginSms> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
