import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netease_music_api/netease_music_api.dart';

import 'common/res.dart';
import 'common/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NeteaseMusicApi.init(debug: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp() {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'zmusic',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: configRouters,
      initialRoute: initialRoute,
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(color: color_text_primary),
              textTheme: TextTheme(
                  headline6:
                      TextStyle(color: color_text_primary, fontSize: 18)),
              color: Colors.transparent,
              elevation: 0,
              brightness: Brightness.light),
          backgroundColor: color_background,
          unselectedWidgetColor: color_primary_shallow),
    );
  }
}
