import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../async_value_widget.dart';
import '../../chapter/domain/chapter.dart';
import '../../garden/domain/garden.dart';
import '../../user/data/user_providers.dart';
import '../../user/domain/user.dart';
import '../data/news_provider.dart';
import '../domain/news.dart';
import '../domain/news_collection.dart';
import 'news_body_item_view.dart';

/// Builds a list of [NewsBodyItemView] (if there are any).
class NewsBodyView extends ConsumerWidget {
  const NewsBodyView({
    super.key,
  });

  final String title = 'News';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String currentUserID = ref.watch(currentUserIDProvider);
    final AsyncValue<List<News>> asyncNews = ref.watch(newsProvider);
    return MultiAsyncValuesWidget(
        context: context,
        currentUserID: currentUserID,
        asyncNews: asyncNews,
        data: _build);
  }

  Widget _build(
      {required BuildContext context,
      required String currentUserID,
      List<Chapter>? chapters,
      List<Garden>? gardens,
      List<News>? news,
      List<User>? users}) {
    NewsCollection newsCollection = NewsCollection(news);
    List<String> newsIDs = newsCollection.getAssociatedNewsIDs(currentUserID);
    return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: (newsIDs.isEmpty)
            ? const Align(
                alignment: Alignment.center,
                child: Text("No news is good news!"))
            : ListView(children: [
                ...newsIDs
                    .map((newsID) => NewsBodyItemView(newsID: newsID))
                    .toList()
              ]));
  }
}
