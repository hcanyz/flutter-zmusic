import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class BotToastExt {
  static CancelFunc showText(
      {@required String text,
      Color contentColor = Colors.white,
      BorderRadiusGeometry borderRadius =
          const BorderRadius.all(Radius.circular(10)),
      TextStyle textStyle =
          const TextStyle(fontSize: 12, color: Colors.black)}) {
    return BotToast.showText(
        text: text,
        contentColor: contentColor,
        borderRadius: borderRadius,
        textStyle: textStyle);
  }
}
