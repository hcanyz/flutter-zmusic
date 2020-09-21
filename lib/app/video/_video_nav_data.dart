class VideoNavData {
  String navName;

  VideoNavData(this.navName);
}

class VideoListPageData {
  String title;
  String describe;
  String albumImgPath;
  String imgPath;
  String playCount;
  String videoTime;
  String praiseCount;
  String commentCount;
  String issuerName;
  String issuerHeadPath;

  VideoListPageData(
      {this.title,
      this.describe,
      this.albumImgPath,
      this.imgPath,
      this.playCount,
      this.videoTime,
      this.praiseCount,
      this.commentCount,
      this.issuerName,
      this.issuerHeadPath});
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

List<VideoListPageData> getVideoListPageDataList() {
  List<VideoListPageData> list = List();
  list.add(VideoListPageData(
      title: "国产电影",
      describe: "这是国产电影的巅峰。。。",
      albumImgPath: "",
      imgPath: "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3281218860,716965592&fm=26&gp=0.jpg",
      playCount: "100",
      videoTime: "00:15",
      praiseCount: "999",
      commentCount: "111",
      issuerName: "周星驰",
      issuerHeadPath: "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=231923533,1272780950&fm=11&gp=0.jpg"));
  list.add(VideoListPageData(
      title: "美国电影",
      describe: "这是美国电影的巅峰。。。",
      albumImgPath: "",
      imgPath: "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1593685324,2253220400&fm=26&gp=0.jpg",
      playCount: "100",
      videoTime: "00:15",
      praiseCount: "999",
      commentCount: "111",
      issuerName: "周星驰",
      issuerHeadPath: "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1666882005,4218080920&fm=26&gp=0.jpg"));
  list.add(VideoListPageData(
      title: "印度电影",
      describe: "这是印度电影的巅峰。。。",
      albumImgPath: "",
      imgPath: "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3043243198,941253136&fm=26&gp=0.jpg",
      playCount: "100",
      videoTime: "00:15",
      praiseCount: "999",
      commentCount: "111",
      issuerName: "周星驰",
      issuerHeadPath: "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=304692675,1993540977&fm=26&gp=0.jpg"));
  list.add(VideoListPageData(
      title: "泰国电影",
      describe: "这是泰国电影的巅峰。。。",
      albumImgPath: "",
      imgPath: "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1589657730,3680653922&fm=26&gp=0.jpg",
      playCount: "100",
      videoTime: "00:15",
      praiseCount: "999",
      commentCount: "111",
      issuerName: "周星驰",
      issuerHeadPath: "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2051339749,99093631&fm=11&gp=0.jpg"));
  return list;
}
