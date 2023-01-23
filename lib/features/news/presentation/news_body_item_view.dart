import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../async_value_widget.dart';
import '../../chapter/application/chapter_provider.dart';
import '../../chapter/domain/chapter.dart';
import '../../chapter/domain/chapter_collection.dart';
import '../../garden/application/garden_provider.dart';
import '../../garden/domain/garden.dart';
import '../../garden/domain/garden_collection.dart';
import '../../user/domain/user.dart';
import '../application/news_provider.dart';
import '../domain/news.dart';
import '../domain/news_collection.dart';
import 'news_body_item_actions.dart';

/// Displays a news item given its ID.
class NewsBodyItemView extends ConsumerWidget {
  NewsBodyItemView({
    super.key,
    required this.newsID,
  });

  final String newsID;
  BuildContext? context;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    this.context = context;
    final AsyncValue<List<Chapter>> asyncChapters = ref.watch(chaptersProvider);
    final AsyncValue<List<Garden>> asyncGardens = ref.watch(gardensProvider);
    final AsyncValue<List<News>> asyncNews = ref.watch(newsProvider);
    return MultiAsyncValuesWidget(
        asyncChapters: asyncChapters,
        asyncGardens: asyncGardens,
        asyncNews: asyncNews,
        data: _build);
  }

  Widget _build(
      {String? currentUserID,
      List<Chapter>? chapters,
      List<Garden>? gardens,
      List<News>? news,
      List<User>? users}) {
    ChapterCollection chapterCollection = ChapterCollection(chapters);
    GardenCollection gardenCollection = GardenCollection(gardens);
    NewsCollection newsCollection = NewsCollection(news);
    News data = newsCollection.getNews(newsID);
    // TODO: set the icon from the data.icon field.
    IconData icon = Icons.newspaper;
    String title = data.title;
    String body = data.body;
    String date = data.date;
    String? chapterID = data.chapterID;
    String? gardenID = data.gardenID;

    /// Only one of chapterID or gardenID is defined.
    String chapterName = (chapterID == null)
        ? ''
        : '${chapterCollection.getChapter(chapterID).name} Chapter';
    String gardenName = (gardenID == null)
        ? ''
        : '${gardenCollection.getGarden(gardenID).name} Garden';
    String bodyPrefix = '$chapterName$gardenName';
    return Column(children: [
      ListTile(
        leading: Icon(icon, color: Theme.of(context!).primaryColor),
        title: Text('$title ($date)'),
        subtitle: Text('$bodyPrefix\n$body'),
        trailing: const NewsBodyItemActions(),
      ),
      const Divider(),
    ]);
  }
}
