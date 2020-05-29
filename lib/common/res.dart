import 'package:flutter/cupertino.dart';

const Color color_primary_shallow = Color(0xffe7756d);

const Color color_secondary = Color(0xffff3a3a);

const Color color_background = Color(0xffdb2c1f);

const Color color_text_secondary = Color(0xff9f9f9f);

const Color color_text_primary = Color(0xff333333);

const Color color_text_hint = Color(0xffd1d1d1);

String joinImageAssetPath(String image, [String app]) {
  if (app == null || app.isEmpty) {
    return 'assets/images/$image';
  }
  return 'lib/app/$app/assets/images/$image';
}
