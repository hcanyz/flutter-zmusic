class VideoNavData {
  String navName;

  VideoNavData(this.navName);
}

List<VideoNavData> getVideoNavDataList() {
  var list = List<VideoNavData>();

  //推荐，LOOK直播，官方，饭圈营业，现场，翻唱，广场，舞蹈，听BGM，MV，生活，游戏，ACG音乐，最佳饭制

  list.add(VideoNavData("推荐"));
  list.add(VideoNavData("LOOK直播"));
  list.add(VideoNavData("官方"));
  list.add(VideoNavData("饭圈营业"));
  list.add(VideoNavData("现场"));
  list.add(VideoNavData("翻唱"));
  list.add(VideoNavData("广场"));
  list.add(VideoNavData("舞蹈"));
  list.add(VideoNavData("听BGM"));
  list.add(VideoNavData("MV"));
  list.add(VideoNavData("生活"));
  list.add(VideoNavData("游戏"));
  list.add(VideoNavData("ACG音乐"));
  list.add(VideoNavData("最佳饭制"));

  return list;
}
