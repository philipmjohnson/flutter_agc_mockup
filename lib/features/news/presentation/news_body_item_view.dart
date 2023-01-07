import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../chapter/application/chapter_provider.dart';
import '../../chapter/domain/chapter_db.dart';
import '../../garden/application/garden_provider.dart';
import '../../garden/domain/garden_db.dart';
import '../application/news_provider.dart';
import '../domain/news_db.dart';
import 'news_body_item_actions.dart';

/// Displays a news item given its ID.
class NewsBodyItemView extends ConsumerWidget {
  const NewsBodyItemView({
    super.key,
    required this.newsID,
  });

  final String newsID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GardenDB gardenDB = ref.watch(gardenDBProvider);
    final ChapterDB chapterDB = ref.watch(chapterDBProvider);
    final NewsDB newsDB = ref.watch(newsDBProvider);
    NewsData data = newsDB.getNews(newsID);
    IconData icon = data.icon;
    String title = data.title;
    String body = data.body;
    String date = data.date;
    String? chapterID = data.chapterID;
    String? gardenID = data.gardenID;

    /// Only one of chapterID or gardenID is defined.
    String chapterName = (chapterID == null)
        ? ''
        : '${chapterDB.getChapter(chapterID).name} Chapter';
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
