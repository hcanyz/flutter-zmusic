import 'package:flutter/cupertino.dart';

const Color zmusic_primary_shallow_color = Color(0xffe7756d);

const Color zmusic_secondary_color = Color(0xffff3a3a);

const Color zmusic_backgroundColor = Color(0xffdb2c1f);

String joinImageAssetPath(String image, [String app]) {
  if (app == null || app.isEmpty) {
    return 'assets/images/$image';
  }
  return 'lib/app/$app/assets/images/$image';
}
