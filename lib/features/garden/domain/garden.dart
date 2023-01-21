import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'garden.freezed.dart';
part 'garden.g.dart';

/// Garden Document.
/// You must tell Firestore to use the 'id' field as the documentID
@freezed
class Garden with _$Garden {
  const factory Garden({
    required String id,
    required String name,
    required String description,
    required String imagePath,
    required String ownerID,
    required String chapterID,
    required String lastUpdate,
    @Default([]) List<String> editorIDs,
    @Default([]) List<String> viewerIDs,
  }) = _Garden;

  factory Garden.fromJson(Map<String, dynamic> json) => _$GardenFromJson(json);

  // Test that the json file can be converted into entities.
  static Future<List<Garden>> checkInitialData() async {
    String content =
        await rootBundle.loadString("assets/initialData/gardens.json");
    List<dynamic> initialData = json.decode(content);
    return initialData.map((jsonData) => Garden.fromJson(jsonData)).toList();
  }
}
