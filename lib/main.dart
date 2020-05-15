import 'package:flutter/material.dart';
import 'package:netease_music_api/netease_music_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NeteaseMusicApi.init(provider: CookiePathProvider(), debug: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'zmusic',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NeteaseMusicApi().homeBannerList().then((value) {});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
