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
            _Banner(_bannerData),
            _DragonBall(_dragonBallData)
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _Banner extends StatefulWidget {
  final BannerListWrap _bannerData;

  _Banner(this._bannerData);

  @override
  _BannerState createState() => _BannerState();
}

class _BannerState extends State<_Banner> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // 长宽比 2.65
      height: (MediaQuery.of(context).size.width - 15 * 2) / 2.65,
      child: PageView.builder(
          itemCount: widget._bannerData?.banners?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget._bannerData.banners[index].pic,
                  fit: BoxFit.fill,
                ),
              ),
            );
          }),
    );
  }
}

class _DragonBall extends StatefulWidget {
  final HomeDragonBallWrap _dragonBallData;

  _DragonBall(this._dragonBallData);

  @override
  _DragonBallState createState() => _DragonBallState();
}

class _DragonBallState extends _FixedSizePageScrollState<_DragonBall> {
  _DragonBallState()
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
            var ballItem = _dragonBallData.data[index];
            Widget iconWidget = Image.network(
              ballItem.iconUrl,
              width: appIconWidth,
              height: appIconWidth,
            );
            // 每日推荐 日期
            if (ballItem.id == -1) {
              iconWidget = Stack(
                alignment: Alignment.center,
                children: [
                  iconWidget,
                  Transform.translate(
                    offset: Offset(0, 2),
                    child: Text(
                      '${DateTime.now().day}',
                      style: TextStyle(
                          color: color_primary_shallow,
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              );
            }
            if (ballItem.skinSupport) {
              iconWidget = DecoratedBox(
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius:
                        BorderRadius.all(Radius.circular(appIconWidth / 2))),
                child: iconWidget,
              );
            }
            return Container(
              width: appIconWidth,
              margin: EdgeInsets.only(right: iconMarginRight),
              child: Column(
                children: [
                  iconWidget,
                  Text(
                    ballItem.name,
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
