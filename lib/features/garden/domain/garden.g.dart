// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'garden.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Garden _$$_GardenFromJson(Map<String, dynamic> json) => _$_Garden(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imagePath: json['imagePath'] as String,
      ownerID: json['ownerID'] as String,
      chapterID: json['chapterID'] as String,
      lastUpdate: json['lastUpdate'] as String,
      editorIDs: (json['editorIDs'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      viewerIDs: (json['viewerIDs'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_GardenToJson(_$_Garden instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imagePath': instance.imagePath,
      'ownerID': instance.ownerID,
      'chapterID': instance.chapterID,
      'lastUpdate': instance.lastUpdate,
      'editorIDs': instance.editorIDs,
      'viewerIDs': instance.viewerIDs,
    };
