import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:zmusic/lib_common/data/music_api.dart';
import 'package:zmusic/vendor/dio_ext.dart';

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
  Future<String> topList() {
    var params = {'limit': 30, 'offset': 0};
    return Https.dio
        .postUri(_joinUri('/weapi/playlist/highquality/list'),
            data: params, options: _joinOptions())
        .then((Response value) {
      debugPrint('$_TAG   topList response ${value.data}');
      return value.toString();
    });
  }

  @override
  Future<String> topListByCategory() {
    var params = {'id': 3779629, 'limit': 30, 'offset': 0};
    return Https.dio
        .postUri(_joinUri('/weapi/v3/playlist/detail'),
            data: params, options: _joinOptions())
        .then((Response value) {
      debugPrint('$_TAG   topListByCategory response ${value.data}');
      return value.toString();
    });
  }

  Options _joinOptions() => Options(contentType: ContentType.json.value);

  Uri _joinUri(String path) {
    return Uri.parse('$_HOST$path');
  }
}
