// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_News _$$_NewsFromJson(Map<String, dynamic> json) => _$_News(
      id: json['id'] as String,
      userID: json['userID'] as String,
      chapterID: json['chapterID'] as String?,
      gardenID: json['gardenID'] as String?,
      iconName: json['iconName'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      date: json['date'] as String,
    );

Map<String, dynamic> _$$_NewsToJson(_$_News instance) => <String, dynamic>{
      'id': instance.id,
      'userID': instance.userID,
      'chapterID': instance.chapterID,
      'gardenID': instance.gardenID,
      'iconName': instance.iconName,
      'title': instance.title,
      'body': instance.body,
      'date': instance.date,
    };
