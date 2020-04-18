import 'package:zmusic/app_home/bean/bean.dart';

abstract class MusicApi {
  Future<String> homeBannerList();

  Future<HighqualityPlayListWrap> highqualityPlayList(int page,
      {int limit = 30});

  Future<CategoryPlayListWrap> categoryPlayList(String categoryId, int page,
      {int limit = 30});

  Future<CategoryPlayListWrap> recommendPlayList(int page, {int limit = 30});
}
