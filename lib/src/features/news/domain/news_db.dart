import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The data associated with users.
class NewsData {
  NewsData({
    required this.id,
    required this.icon,
    required this.title,
    required this.body,
    required this.date,
    required this.userID,
    this.chapterID,
    this.gardenID,
  });

  String id;
  IconData icon;
  String title;
  String body;
  String date;
  String userID;
  String? chapterID;
  String? gardenID;
}

/// Provides access to and operations on all defined News items.
class NewsDB {
  NewsDB(this.ref);
  final ProviderRef<NewsDB> ref;
  final List<NewsData> _news = [
    NewsData(
        id: 'news-001',
        userID: 'user-001',
        chapterID: 'chapter-001',
        icon: Icons.severe_cold,
        title: 'Frost Alert',
        body: 'Predicted overnight low of 37\u00B0 for 11/15/22',
        date: '11/15/22'),
    NewsData(
        id: 'news-002',
        userID: 'user-001',
        gardenID: 'garden-001',
        icon: Icons.image_search,
        title: 'Reply to: "Something is eating these bean sprouts...',
        body: '... Looks like it could be a rabbit or...',
        date: '11/10/22'),
    NewsData(
        id: 'news-003',
        userID: 'user-001',
        chapterID: 'chapter-001',
        icon: Icons.group_add,
        title: 'New Chapter Members',
        body: '@AsaD, @CyTheGuy',
        date: '11/20/22'),
    NewsData(
        id: 'news-004',
        userID: 'user-001',
        chapterID: 'chapter-001',
        icon: Icons.water_drop,
        title: 'New seed(s) available',
        body:
            "Lettuce (Flashy Trout's Back), Bean (Tanya's Pink Pod), Squash (Zepplin Delicata)",
        date: '11/25/22'),
    NewsData(
        id: 'news-005',
        userID: 'user-001',
        gardenID: 'garden-002',
        icon: Icons.yard_outlined,
        title: 'First Harvest expected',
        body: "Pepper (Bridge to Paris), Pumpkin (Winter Luxury)",
        date: '11/25/22'),
    NewsData(
        id: 'news-006',
        userID: 'user-001',
        chapterID: 'chapter-001',
        icon: Icons.pest_control,
        title: 'Pest Alert: Aphids',
        body: "10 gardens with Aphid pest observations this week",
        date: '11/30/22'),
  ];

  List<String> getNewsIDs() {
    return _news.map((data) => data.id).toList();
  }

  NewsData getNews(newsID) {
    return _news.firstWhere((data) => data.id == newsID);
  }

  List<String> getAssociatedNewsIDs(String userID) {
    return getNewsIDs()
        .where((newsID) => getNews(newsID).userID == userID)
        .toList();
  }
}
