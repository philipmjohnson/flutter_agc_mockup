import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../user/application/user_providers.dart';
import '../application/news_provider.dart';
import '../domain/news_db.dart';
import 'news_body_item_view.dart';

/// Displays a list of News items (if there are any).
class NewsBodyView extends ConsumerWidget {
  const NewsBodyView({
    super.key,
  });

  final String title = 'Home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserID = ref.watch(currentUserIDProvider);
    final NewsDB newsDB = ref.watch(newsDBProvider);
    List<String> newsIDs = newsDB.getAssociatedNewsIDs(currentUserID);
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
