import 'package:json_annotation/json_annotation.dart';
import 'package:zmusic/lib_common/bean/bean.dart';

part 'bean.g.dart';

@JsonSerializable()
class OverallListItem {
  @JsonKey(fromJson: _stringFromInt, toJson: _stringToInt)
  String id;

  //歌单名
  String name;
  String description;
  String coverImgUrl;

  String tag;
  List<String> tags;
  String copywriter;

  int createTime;
  int updateTime;

  int playCount;
  int subscribedCount;
  int shareCount;
  int commentCount;

  int trackCount;
  int trackNumberUpdateTime;

  OverallListItem();

  factory OverallListItem.fromJson(Map<String, dynamic> json) =>
      _$OverallListItemFromJson(json);

  Map<String, dynamic> toJson() => _$OverallListItemToJson(this);

  static int _stringToInt(String number) =>
      number == null ? null : int.parse(number);

  static String _stringFromInt(int number) => number?.toString();
}

@JsonSerializable()
class OverallListWrap extends ServerStatusBean {
  List<OverallListItem> playlists;

  OverallListWrap();

  factory OverallListWrap.fromJson(Map<String, dynamic> json) =>
      _$OverallListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$OverallListWrapToJson(this);
}
