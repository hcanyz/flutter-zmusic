import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:zmusic/app_home/bean/bean.dart';
import 'package:zmusic/vendor/dio_ext.dart';

import 'music_api.dart';
import 'netease_util.dart';

class NeteaseMusicApi implements MusicApi {
  static const String _TAG = 'NeteaseMusicApi';
  static const String _HOST = 'https://music.163.com';

  static NeteaseMusicApi _musicApi;

  NeteaseMusicApi._internal() {
    Https.dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions option) async {
      if (option.method == 'POST' && _HOST.contains(option.uri.host)) {
        debugPrint(
            '$_TAG   interceptor before: ${option.uri}   ${option.data}');
        neteaseInterceptor(option);
        debugPrint('$_TAG   interceptor after: ${option.uri}   ${option.data}');
      }
    }));
  }

  factory NeteaseMusicApi() {
    return _musicApi ??= NeteaseMusicApi._internal();
  }

  @override
  Future<HighqualityPlayListWrap> highqualityPlayList(int page,
      {int limit = 30}) {
    var params = {'limit': limit, 'offset': page * limit};
    return Https.dio
        .postUri(_joinUri('/weapi/playlist/highquality/list'),
            data: params, options: _joinOptions())
        .then((Response value) {
      debugPrint('$_TAG   topList response ${value.data}');
      return HighqualityPlayListWrap.fromJson(jsonDecode(value.data));
    });
  }

  static const PLAYLIST_CATEGORY = [
    {"name": "云音乐新歌榜", "id": "3779629"},
    {"name": "云音乐热歌榜", "id": "3778678"},
    {"name": "云音乐原创榜", "id": "2884035"},
    {"name": "云音乐飙升榜", "id": "19723756"},
    {"name": "云音乐电音榜", "id": "10520166"},
    {"name": "UK排行榜周榜", "id": "180106"},
    {"name": "美国Billboard周榜", "id": "60198"},
    {"name": "KTV嗨榜", "id": "21845217"},
    {"name": "iTunes榜", "id": "11641012"},
    {"name": "Hit FM Top榜", "id": "120001"},
    {"name": "日本Oricon周榜", "id": "60131"},
    {"name": "韩国Melon排行榜周榜", "id": "3733003"},
    {"name": "韩国Mnet排行榜周榜", "id": "60255"},
    {"name": "韩国Melon原声周榜", "id": "46772709"},
    {"name": "中国TOP排行榜(港台榜)", "id": "112504"},
    {"name": "中国TOP排行榜(内地榜)", "id": "64016"},
    {"name": "香港电台中文歌曲龙虎榜", "id": "10169002"},
    {"name": "华语金曲榜", "id": "4395559"},
    {"name": "中国嘻哈榜", "id": "1899724"},
    {"name": "法国 NRJ EuroHot 30周榜", "id": "27135204"},
    {"name": "台湾Hito排行榜", "id": "112463"},
    {"name": "Beatport全球电子舞曲榜", "id": "3812895"},
    {"name": "云音乐ACG音乐榜", "id": "71385702"},
    {"name": "云音乐说唱榜,", "id": "991319590"},
    {"name": "云音乐古典音乐榜", "id": "71384707"},
    {"name": "云音乐电音榜", "id": "1978921795"},
    {"name": "抖音排行榜", "id": "2250011882"},
    {"name": "新声榜", "id": "2617766278"},
    {"name": "云音乐韩语榜", "id": "745956260"},
    {"name": "英国Q杂志中文版周榜", "id": "2023401535"},
    {"name": "电竞音乐榜", "id": "2006508653"},
    {"name": "云音乐欧美热歌榜", "id": "2809513713"},
    {"name": "云音乐欧美新歌榜", "id": "2809577409"},
    {"name": "说唱TOP榜", "id": "2847251561"},
    {"name": "云音乐ACG动画榜", "id": "3001835560"},
    {"name": "云音乐ACG游戏榜", "id": "3001795926"},
    {"name": "云音乐ACG VOCALOID榜", "id": "3001890046"}
  ];

  @override
  Future<CategoryPlayListWrap> categoryPlayList(String categoryId, int page,
      {int limit = 30}) {
    var params = {'id': categoryId, 'limit': limit, 'offset': page * limit};
    return Https.dio
        .postUri(_joinUri('/weapi/v3/playlist/detail'),
            data: params, options: _joinOptions())
        .then((Response value) {
      debugPrint('$_TAG   topListByCategory response ${value.data}');
      return CategoryPlayListWrap.fromJson(jsonDecode(value.data));
    });
  }

  Options _joinOptions() => Options(contentType: ContentType.json.value);

  Uri _joinUri(String path) {
    return Uri.parse('$_HOST$path');
  }
}
