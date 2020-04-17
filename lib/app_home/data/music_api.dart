import 'package:zmusic/app_home/bean/bean.dart';

abstract class MusicApi {
  Future<HighqualityPlayListWrap> highqualityPlayList();

  Future<CategoryPlayListWrap> categoryPlayList();
}
