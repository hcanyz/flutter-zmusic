import 'package:flutter/cupertino.dart';

const Color zmusic_secondary_color = Color(0xffe3584e);

const Color zmusic_backgroundColor = Color(0xffdb2c1f);

String joinImageAssetPath(String app, String image) {
  if (app == null || app.isEmpty) {
    return 'assets/images/$image';
  }
  return 'lib/app/$app/assets/images/$image';
}
