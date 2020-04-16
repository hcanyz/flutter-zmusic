// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OverallListItem _$OverallListItemFromJson(Map<String, dynamic> json) {
  return OverallListItem()
    ..id = OverallListItem._stringFromInt(json['id'] as int)
    ..name = json['name'] as String
    ..description = json['description'] as String
    ..coverImgUrl = json['coverImgUrl'] as String
    ..tag = json['tag'] as String
    ..tags = (json['tags'] as List)?.map((e) => e as String)?.toList()
    ..copywriter = json['copywriter'] as String
    ..createTime = json['createTime'] as int
    ..updateTime = json['updateTime'] as int
    ..playCount = json['playCount'] as int
    ..subscribedCount = json['subscribedCount'] as int
    ..shareCount = json['shareCount'] as int
    ..commentCount = json['commentCount'] as int
    ..trackCount = json['trackCount'] as int
    ..trackNumberUpdateTime = json['trackNumberUpdateTime'] as int;
}

Map<String, dynamic> _$OverallListItemToJson(OverallListItem instance) =>
    <String, dynamic>{
      'id': OverallListItem._stringToInt(instance.id),
      'name': instance.name,
      'description': instance.description,
      'coverImgUrl': instance.coverImgUrl,
      'tag': instance.tag,
      'tags': instance.tags,
      'copywriter': instance.copywriter,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime,
      'playCount': instance.playCount,
      'subscribedCount': instance.subscribedCount,
      'shareCount': instance.shareCount,
      'commentCount': instance.commentCount,
      'trackCount': instance.trackCount,
      'trackNumberUpdateTime': instance.trackNumberUpdateTime,
    };

OverallListWrap _$OverallListWrapFromJson(Map<String, dynamic> json) {
  return OverallListWrap()
    ..code = json['code'] as int
    ..playlists = (json['playlists'] as List)
        ?.map((e) => e == null
            ? null
            : OverallListItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$OverallListWrapToJson(OverallListWrap instance) =>
    <String, dynamic>{
      'code': instance.code,
      'playlists': instance.playlists,
    };
