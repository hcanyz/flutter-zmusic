import 'package:flutter/material.dart';
import 'package:zmusic/app/discovery/z_api.dart';
import 'package:zmusic/common/res.dart';
import 'package:zmusic/widget/autotextsize_tabbar.dart';

class HomeMain extends StatefulWidget {
  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> with TickerProviderStateMixin {
  final List<String> _tabValues = [
    '我的',
    '发现',
    '云村',
    '视频',
  ];
  final int initialIndex = 1;

  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
        initialIndex: initialIndex, length: _tabValues.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          titlePadding: EdgeInsets.only(bottom: 3),
          title: AutoTextSizeTabBar(
            tabBarTexts: _tabValues,
            controller: _controller,
            defaultTextStyle:
                TextStyle(fontSize: 15, color: color_text_secondary),
            selectTextStyle: TextStyle(fontSize: 18, color: color_text_primary),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: TabBarView(
        controller: _controller,
        children: _tabValues.asMap().entries.map((e) {
          if (e.key == 1) {
            return buildDiscoveryMain();
          }
          return Center(
            child: Text(e.value),
          );
        }).toList(),
      ),
    );
  }
}
