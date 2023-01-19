import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'news.freezed.dart';
part 'news.g.dart';

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

  factory News.fromFirestore(Map<String, dynamic> json, String documentId) {
    return News(
      id: documentId,
      userID: json['userID'],
      chapterID: json['chapterID'],
      gardenID: json['gardenID'],
      iconName: json['iconName'],
      title: json['title'],
      body: json['body'],
      date: json['date'],
    );
  }

  // Test that the json file can be converted into entities.
  static Future<List<News>> checkInitialData() async {
    String content =
        await rootBundle.loadString("assets/initialData/news.json");
    List<dynamic> initialData = json.decode(content);
    return initialData.map((jsonData) => News.fromJson(jsonData)).toList();
  }
}
