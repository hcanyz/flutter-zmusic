import 'package:zmusic/app_home/bean/bean.dart';

abstract class MusicApi {
  Future<OverallListWrap> topList();

  Future<String> topListByCategory();
}
