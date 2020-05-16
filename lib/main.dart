import 'package:flutter/material.dart';
import 'package:netease_music_api/netease_music_api.dart';

import 'app/common/res.dart';
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NeteaseMusicApi.init(debug: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'zmusic',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: configRouters,
      initialRoute: initialRoute,
      theme: ThemeData(backgroundColor: zmusic_backgroundColor),
    );
  }
}
