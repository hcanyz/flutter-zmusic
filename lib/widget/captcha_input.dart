import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zmusic/common/res.dart';

class CaptchaInput extends StatefulWidget {
  final ValueChanged<List<String>> _captchaChanged;

  CaptchaInput([this._captchaChanged]);

  @override
  _CaptchaInputState createState() => _CaptchaInputState();
}

class _CaptchaInputState extends State<CaptchaInput> {
  static const _captchaSize = 4;
  static const _whiteSpace = ' ';

  List<String> _captcha;
  List<FocusNode> _focusNodes;

  void _captchaChange(index, String str) {
    if (str != _whiteSpace) {
      _captcha[index] = str;
      if (isStrEmpty(str)) {
        _moveItem(index, true);
      } else {
        _moveEmptyItemOrDone(index);
      }
    }
  }

  void _moveItem(index, bool pre) {
    FocusScope.of(context)
        .requestFocus(_focusNodes[(index + (pre ? -1 : 1)) % _captchaSize]);
  }

  void _moveEmptyItemOrDone(index) {
    var findFocusCaptcha = _captcha.sublist(index) + _captcha.sublist(0, index);

    var emptyIndex = findFocusCaptcha.indexWhere((str) => isStrEmpty(str));

    if (emptyIndex != -1) {
      FocusScope.of(context)
          .requestFocus(_focusNodes[(emptyIndex + index) % _captchaSize]);
    } else {
      FocusScope.of(context).unfocus();
      if (widget._captchaChanged != null) {
        widget._captchaChanged(_captcha);
      }
    }
  }

  bool isStrEmpty(String str) {
    return str.isEmpty || str == _whiteSpace;
  }

  @override
  void initState() {
    super.initState();
    _captcha = List.filled(_captchaSize, _whiteSpace);
    _focusNodes = List.generate(_captchaSize, (index) {
      return FocusNode()
        ..addListener(() {
          if (_captcha[index].isEmpty) {
            setState(() {
              _captcha[index] = _whiteSpace;
            });
          }
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: buildCaptchaInput(),
    );
  }

  List<Widget> buildCaptchaInput() {
    return List.generate(_captchaSize, (index) {
      return SizedBox(
          width: 48,
          child: TextField(
            cursorWidth: 0,
            textAlign: TextAlign.center,
            enableInteractiveSelection: false,
            keyboardType: TextInputType.number,
            inputFormatters: [
              _CaptchaInputFormatter(_whiteSpace),
              FilteringTextInputFormatter.allow(RegExp('[\\d$_whiteSpace]*'))
            ],
            decoration: InputDecoration(
              isDense: true,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: color_text_secondary)),
            ),
            textInputAction: TextInputAction.next,
            controller: TextEditingController.fromValue(TextEditingValue(
                text: _captcha[index],
                selection: TextSelection.collapsed(
                    offset: _captcha[index].length,
                    affinity: TextAffinity.upstream))),
            onSubmitted: (str) {
              _moveItem(index, false);
            },
            autofocus: index == 0,
            focusNode: _focusNodes[index],
            onChanged: (str) {
              _captchaChange(index, str);
            },
          ));
    });
  }
}

class _CaptchaInputFormatter extends TextInputFormatter {
  String _whiteSpace;

  _CaptchaInputFormatter(this._whiteSpace);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var result = '';
    if (newValue.text == '') {
      if (oldValue.text != _whiteSpace) {
        result = _whiteSpace;
      } else {
        return newValue;
      }
    } else {
      result = newValue.text.substring(newValue.text.length - 1);
    }
    return TextEditingValue(
        text: result, selection: TextSelection.collapsed(offset: 1));
  }
}
