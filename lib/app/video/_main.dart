import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zmusic/app/video/z_api.dart';
import 'package:zmusic/common/res.dart';

import '_video_nav_data.dart';
import '_video_tab_indicator.dart';

class VideoMain extends StatefulWidget {
  @override
  _VideoMainState createState() => _VideoMainState();
}

class _VideoMainState extends State<VideoMain> {
  final List<VideoNavData> _list = getVideoNavDataList();

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _list.length,
      vsync: ScrollableState(),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          titlePadding: EdgeInsets.only(bottom: 3),
          title: TabBar(
            tabs: _list
                .map((e) => Tab(
                      text: e.navName,
                    ))
                .toList(),
            controller: _tabController,
            isScrollable: true,
            indicator: VideoTabIndicator(
              borderSide: BorderSide(
                width: 2.0,
                color: Colors.red,
              ),
            ),
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
            labelColor: Colors.red,
            unselectedLabelColor: color_text_primary,
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _list.asMap().entries.map((e) {
                if(e.key == 0){
                  return buildVideoListPage();
                }
                return Center(
                  child: Text(
                    e.value.navName,
                    style: TextStyle(color: Colors.red, fontSize: 30),
                  ),
                );
              }
            )
            .toList(),
      ),
    );
  }
}
