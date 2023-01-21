import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'news.freezed.dart';
part 'news.g.dart';

/// News Document.
/// You must tell Firestore to use the 'id' field as the documentID
@freezed
class News with _$News {
  const factory News({
    required String id,
    required String userID,
    String? chapterID,
    String? gardenID,
    required String iconName,
    required String title,
    required String body,
    required String date,
  }) = _News;

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);

  // Test that the json file can be converted into entities.
  static Future<List<News>> checkInitialData() async {
    String content =
        await rootBundle.loadString("assets/initialData/news.json");
    List<dynamic> initialData = json.decode(content);
    return initialData.map((jsonData) => News.fromJson(jsonData)).toList();
  }
}
