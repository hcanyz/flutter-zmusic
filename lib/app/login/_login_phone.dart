import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netease_music_api/netease_music_api.dart';
import 'package:zmusic/app/home/z_api.dart';
import 'package:zmusic/app/login/z_api.dart';
import 'package:zmusic/common/res.dart';
import 'package:zmusic/common/toast_ext.dart';
import 'package:zmusic/widget/captcha_input.dart';
import 'package:zmusic/widget/choose_countries.dart';

class PhoneCheck extends StatefulWidget {
  @override
  _PhoneCheckState createState() => _PhoneCheckState();
}

class _PhoneCheckState extends State<PhoneCheck> {
  var _phoneNum = '';
  var _verified = false;

  void _checkPhone() async {
    if (!_phoneNumChange(_phoneNum)) {
      BotToastExt.showText(text: '请输入正确的手机号');
      return;
    }
    var result = await NeteaseMusicApi()
        .checkCellPhoneExistence(_phoneNum, countrycode: _countryCode);
    if (result.codeEnum != RetCode.Ok) {
      return;
    }
    if (result.needUseSms) {
      skipLoginPhoneSms(context, _phoneNum, _countryCode);
    } else {
      skipLoginPhonePassword(context, _phoneNum, _countryCode);
    }
  }

  bool _phoneNumChange(String str) {
    _phoneNum = str;
    var verified = RegExp(r'[1]\d{10}').hasMatch(_phoneNum);
    if (verified != _verified) {
      setState(() {
        _verified = verified;
      });
    }
    return verified;
  }

  var _countryCode = "86";
  var _repetitionClick = true;

  void _setCountryCode(String code) {
    _repetitionClick = true;
    if (code.isNotEmpty) {
      setState(() {
        _countryCode = code;
      });
    }
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
              style: const TextStyle(color: color_text_secondary, fontSize: 13),
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
                          "+$_countryCode",
                          style: TextStyle(color: color_text_primary),
                        ),
                        GestureDetector(
                          onTap: () => {
                            if (_repetitionClick)
                              {
                                _repetitionClick = false,
                                showChooseCountriesDialog(context, (value) {
                                  _setCountryCode(value);
                                })
                              }
                          },
                          child: Icon(
                            Icons.arrow_drop_down,
                            color: color_text_primary,
                          ),
                        ),
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
                color: _verified ? color_secondary : color_secondary_shallow,
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
  final String _countryCode;

  PhoneLoginPassword(this._phoneNum, this._countryCode);

  @override
  _PhoneLoginPasswordState createState() => _PhoneLoginPasswordState();
}

class _PhoneLoginPasswordState extends State<PhoneLoginPassword> {
  var _phonePassword = '';
  var _verified = false;

  void _loginByPassword() async {
    if (!_passwordChange7check(_phonePassword)) {
      BotToastExt.showText(text: '请输入密码');
      return;
    }
    var result = await NeteaseMusicApi().loginCellPhone(
        widget._phoneNum, _phonePassword,
        countryCode: widget._countryCode);

    if (result.codeEnum != RetCode.Ok) {
      BotToastExt.showText(text: result.realMsg);
      return;
    }
    skipHomeMainSingleTask(context);
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
                color: _verified ? color_secondary : color_secondary_shallow,
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
  final String _countryCode;

  PhoneLoginSms(this._phoneNum, this._countryCode);

  @override
  _PhoneLoginSmsState createState() => _PhoneLoginSmsState();
}

class _PhoneLoginSmsState extends State<PhoneLoginSms> {
  void _verifyCaptcha(List<String> captcha) async {
    var captchaStr = captcha.join();
    var result = await NeteaseMusicApi().captchaVerify(
        widget._phoneNum, captcha.join(),
        ctcode: widget._countryCode);
    if (result.codeEnum == RetCode.Ok) {
      skipLoginRegister(context, widget._phoneNum, captchaStr);
    } else {
      BotToastExt.showText(text: result.realMsg);
    }
  }

  void _resendCaptcha() async {
    var result = await NeteaseMusicApi()
        .captchaSend(widget._phoneNum, ctcode: widget._countryCode);
    if (result.codeEnum == RetCode.Ok) {}
    BotToastExt.showText(text: result.realMsg);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('手机号验证'),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 59),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '验证码已发送至',
              style: TextStyle(fontSize: 17, color: color_text_primary),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '+${widget._countryCode} ${widget._phoneNum.replaceRange(3, 7, '****')}',
                  style: TextStyle(fontSize: 15, color: color_text_secondary),
                ),
                GestureDetector(
                  onTap: _resendCaptcha,
                  child: Text(
                    '重新获取',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 45, right: 45, top: 46),
              child: CaptchaInput(_verifyCaptcha),
            ),
          ],
        ),
      ),
    );
  }
}

class PhoneLoginRegister extends StatefulWidget {
  final String _phoneNum;
  final String _captcha;

  PhoneLoginRegister(this._phoneNum, this._captcha);

  @override
  _PhoneLoginRegisterState createState() => _PhoneLoginRegisterState();
}

class _PhoneLoginRegisterState extends State<PhoneLoginRegister> {
  var _phonePassword = '';
  var _verified = false;

  void _loginByPassword() async {
    if (!_passwordChange7check(_phonePassword)) {
      BotToastExt.showText(text: '请输入合适的密码');
      return;
    }
    var result = await NeteaseMusicApi()
        .registerCellPhone(widget._phoneNum, _phonePassword, widget._captcha);

    if (result.codeEnum != RetCode.Ok) {
      BotToastExt.showText(text: result.realMsg);
      return;
    }
    skipHomeMainSingleTask(context);
  }

  bool _passwordChange7check(String str) {
    _phonePassword = str;
    var verified = RegExp(
            r'((?=.*\d)(?=.*\D)|(?=.*[a-zA-Z])(?=.*[^a-zA-Z]))(?!^.*[\u4E00-\u9FA5].*$)^\S{8,20}$')
        .hasMatch(str);
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
        title: Text('手机号注册'),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '请设置登录密码，8-20位字符，至少包含字母/数字/符号2种组合',
              style: const TextStyle(color: color_text_secondary, fontSize: 13),
            ),
            TextField(
              autofocus: true,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              onChanged: _passwordChange7check,
              decoration: InputDecoration(
                  errorText: _verified ? null : '请输入合适的密码',
                  hintStyle: TextStyle(color: color_text_hint)),
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
                color: _verified ? color_secondary : color_secondary_shallow,
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
