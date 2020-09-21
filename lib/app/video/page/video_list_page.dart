import 'package:flutter/material.dart';
import 'package:zmusic/common/res.dart';

import '../_video_nav_data.dart';

class VideoListPage extends StatefulWidget {
  @override
  _VideoListPageState createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage> {
  List<VideoListPageData> _list = getVideoListPageDataList();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _list.map((e) => _getItem(context, e)).toList(),
    );
  }

  Widget _getItem(BuildContext context, VideoListPageData item) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200.0,
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(item.imgPath)),
              ),
            ),
            Positioned(
              top: 30.0,
              right: 30.0,
              child: Container(
                padding: EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 1.0, bottom: 1.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Colors.white,width: 0.5),
                ),
                alignment: Alignment.center,
                child: Text(
                  item.title,
                  style: TextStyle(color: Colors.white, fontSize: 13.0),
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Row(
            children: [
              Text(
                item.describe,
                style: TextStyle(color: color_text_primary, fontSize: 16.0),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
          height: 1.0,
          color: Colors.grey[200],
        ),
        Container(
          margin:
              EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Container(
                width: 30.0,
                height: 30.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    image: NetworkImage(item.issuerHeadPath),
                  ),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Text(
                  item.issuerName,
                  style: TextStyle(fontSize: 16.0, color: color_text_primary),
                ),
              ),
              Stack(
                children: [
                  Container(
                    width: 30.0,
                    height: 30.0,
                  ),
                  Positioned(
                    bottom: 5,
                    left: 0,
                    child: Image(
                      width: 20.0,
                      height: 20.0,
                      image:
                          AssetImage(joinImageAssetPath('praise.png', 'video')),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Text(
                      "999",
                      style: TextStyle(
                          fontSize: 10.0, color: color_text_secondary),
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 20.0,
              ),
              Stack(
                children: [
                  Container(
                    width: 30.0,
                    height: 30.0,
                  ),
                  Positioned(
                    bottom: 5,
                    left: 0,
                    child: Image(
                      width: 20.0,
                      height: 20.0,
                      image: AssetImage(
                          joinImageAssetPath('comment.png', 'video')),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      color: Colors.white,
                      child: Text(
                        "999",
                        style: TextStyle(
                            fontSize: 10.0, color: color_text_secondary),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 20.0,
              ),
              Image(
                width: 20.0,
                height: 20.0,
                image: AssetImage(joinImageAssetPath('more.png', 'video')),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.grey[200],
          height: 8.0,
        ),
      ],
    );
  }
}
