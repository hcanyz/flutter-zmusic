import 'package:zmusic/app_home/bean/bean.dart';

abstract class MusicApi {
  Future<HighqualityPlayListWrap> highqualityPlayList(int page,
      {int limit = 30});

  Future<CategoryPlayListWrap> categoryPlayList(String categoryId, int page,
      {int limit = 30});
}
