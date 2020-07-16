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

  BannerListWrap _bannerData;
  HomeDragonBallWrap _dragonBallData;
  HomeBlockPageWrap _blockPageData;

  _requestData(bool refresh) async {
    var api = NeteaseMusicApi();
    var bannerMetaData = api.homeBannerListDioMetaData();
    var dragonBallMetaData = api.homeDragonBallStaticDioMetaData();
    var blockPageMetaData = api.homeBlockPageDioMetaData(refresh: refresh);

    var data = await api
        .batchApi([bannerMetaData, dragonBallMetaData, blockPageMetaData]);

    setState(() {
      _bannerData =
          BannerListWrap.fromJson(data.findResponseData(bannerMetaData));
      _dragonBallData = HomeDragonBallWrap.fromJson(
          data.findResponseData(dragonBallMetaData));
      _blockPageData =
          HomeBlockPageWrap.fromJson(data.findResponseData(blockPageMetaData));
    });
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
            Padding(padding: EdgeInsets.only(top: 5)),
            Container(
              // 长宽比 2.65
              height: (MediaQuery.of(context).size.width - 15 * 2) / 2.65,
              child: PageView.builder(
                  itemCount: _bannerData?.banners?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          _bannerData.banners[index].pic,
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  }),
            ),
            _AppQuickEntrance(_dragonBallData)
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _AppQuickEntrance extends StatefulWidget {
  final HomeDragonBallWrap _dragonBallData;

  _AppQuickEntrance(this._dragonBallData);

  @override
  _AppQuickEntranceState createState() => _AppQuickEntranceState();
}

class _AppQuickEntranceState
    extends _FixedSizePageScrollState<_AppQuickEntrance> {
  _AppQuickEntranceState()
      : super(appIconCount: 5.5, appIconWidth: 40, appIconUnusedWidth: 15);

  @override
  Widget build(BuildContext context) {
    final HomeDragonBallWrap _dragonBallData = widget._dragonBallData;
    super.build(context);
    return Container(
      height: 83,
      padding: EdgeInsets.only(left: appIconUnusedWidth, top: 15),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: FixedSizePageScrollPhysics(itemDimension: iconDimension),
          itemCount: _dragonBallData?.data?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: appIconWidth,
              margin: EdgeInsets.only(right: iconMarginRight),
              child: Column(
                children: [
                  Image.network(
                    _dragonBallData.data[index].iconUrl,
                    width: appIconWidth,
                    height: appIconWidth,
                  ),
                  Text(
                    _dragonBallData.data[index].name,
                    style: TextStyle(fontSize: 10, color: color_text_secondary),
                  )
                ],
              ),
            );
          }),
    );
  }
}

abstract class _FixedSizePageScrollState<T extends StatefulWidget>
    extends State<T> {
  // 显示个数
  final double appIconCount;

  // 条目使用宽度
  final double appIconWidth;

  // 忽略宽度
  final double appIconUnusedWidth;

  @protected
  double iconMarginRight = 0;

  @protected
  double iconDimension = 0;

  _FixedSizePageScrollState(
      {this.appIconCount, this.appIconWidth, this.appIconUnusedWidth});

  @override
  Widget build(BuildContext context) {
    if (iconMarginRight == 0 || iconDimension == 0) {
      iconMarginRight = (MediaQuery.of(context).size.width -
              appIconUnusedWidth -
              appIconWidth * appIconCount) /
          appIconCount.floor();
      iconDimension = appIconWidth + iconMarginRight;
    }
    return null;
  }
}
