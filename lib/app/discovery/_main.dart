import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:netease_music_api/netease_music_api.dart';
import 'package:zmusic/common/res.dart';
import 'package:zmusic/widget/scroll_physics_ext.dart';

class DiscoveryMain extends StatefulWidget {
  @override
  _DiscoveryMainState createState() => _DiscoveryMainState();
}

class _DiscoveryMainState extends State<DiscoveryMain>
    with AutomaticKeepAliveClientMixin {
  var _indicator = new GlobalKey<RefreshIndicatorState>();

  _requestData(bool refresh) async {
    var api = NeteaseMusicApi();
    //    var result = await api.batchApi([
    //      api.homeBannerListDioMetaData(),
    //      api.homeBlockPageDioMetaData(refresh: refresh)
    //    ]);
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _indicator.currentState?.show(atTop: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      key: _indicator,
      onRefresh: () {
        return _requestData(true);
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 125,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: PageView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Image.network(
                      'https://user-gold-cdn.xitu.io/2019/12/24/16f36a7d1d4bde88?imageView2/1/w/100/h/100/q/85/format/webp/interlace/1',
                    );
                  }),
            ),
            _AppQuickEntrance()
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _AppQuickEntrance extends StatefulWidget {
  @override
  _AppQuickEntranceState createState() => _AppQuickEntranceState();
}

class _AppQuickEntranceState extends State<_AppQuickEntrance> {
  // 广告栏下面的app icon 最多显示个数
  static const double _appIconCount = 5.5;
  static const double _appIconSize = 40;
  static const double _appIconUnusedWidth = 15;

  double _iconMarginRight = 0;
  double _iconDimension = 0;

  @override
  Widget build(BuildContext context) {
    if (_iconMarginRight == 0 || _iconDimension == 0) {
      _iconMarginRight = (MediaQuery.of(context).size.width -
              _appIconUnusedWidth -
              _appIconSize * _appIconCount) /
          _appIconCount.floor();
      _iconDimension = _appIconSize + _iconMarginRight;
    }
    return Container(
      height: 83,
      padding: const EdgeInsets.only(left: _appIconUnusedWidth, top: 15),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: FixedSizePageScrollPhysics(itemDimension: _iconDimension),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: _appIconSize,
              margin: EdgeInsets.only(right: _iconMarginRight),
              child: Column(
                children: [
                  Image.network(
                    'https://user-gold-cdn.xitu.io/2019/12/24/16f36a7d1d4bde88?imageView2/1/w/100/h/100/q/85/format/webp/interlace/1',
                    width: _appIconSize,
                    height: _appIconSize,
                  ),
                  Text(
                    '每日推荐',
                    style: TextStyle(fontSize: 10, color: color_text_secondary),
                  )
                ],
              ),
            );
          }),
    );
  }
}
