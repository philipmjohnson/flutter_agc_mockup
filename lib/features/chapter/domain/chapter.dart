import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chapter.freezed.dart';
part 'chapter.g.dart';

/// Chapter data model.
/// Be sure to tell Firestore to use the id field as the documentID.
@freezed
class Chapter with _$Chapter {
  const factory Chapter({
    required String id,
    required String name,
    required String imagePath,
    required List<String> zipCodes,
    required List<String> hardinessZones,
  }) = _Chapter;

  factory Chapter.fromJson(Map<String, dynamic> json) =>
      _$ChapterFromJson(json);

  // Test that the json file can be converted into entities.
  static Future<List<Chapter>> checkInitialData() async {
    String content =
        await rootBundle.loadString("assets/initialData/chapters.json");
    List<dynamic> initialData = json.decode(content);
    return initialData.map((jsonData) => Chapter.fromJson(jsonData)).toList();
  }
}
