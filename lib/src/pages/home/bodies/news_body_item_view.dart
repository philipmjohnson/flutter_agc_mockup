import 'package:flutter/material.dart';
import 'package:flutter_agc_mockup/src/pages/home/bodies/news_body_item_actions.dart';
import '../../../data_model/chapter_db.dart';
import '../../../data_model/garden_db.dart';
import '../../../data_model/news_db.dart';

/// Displays a news item given its ID.
class NewsBodyItemView extends StatelessWidget {
  const NewsBodyItemView({
    super.key,
    required this.newsID,
  });

  final String newsID;

  @override
  Widget build(BuildContext context) {
    NewsData data = newsDB.getNews(newsID);
    IconData icon = data.icon;
    String title = data.title;
    String body = data.body;
    String date = data.date;
    String? chapterID = data.chapterID;
    String? gardenID = data.gardenID;
    /// Only one of chapterID or gardenID is defined.
    String chapterName =
        (chapterID == null) ? '' : '${chapterDB.getChapter(chapterID).name} Chapter';
    String gardenName =
        (gardenID == null) ? '' : '${gardenDB.getGarden(gardenID).name} Garden';
    String bodyPrefix = '$chapterName$gardenName';
    return Column(children: [
      ListTile(
        leading: Icon(icon, color: Theme.of(context).primaryColor),
        title: Text('$title ($date)'),
        subtitle: Text('$bodyPrefix\n$body'),
        trailing: const NewsBodyItemActions(),
      ),
      const Divider(),
    ]);
  }
}
