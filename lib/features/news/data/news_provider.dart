import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/news.dart';
import 'news_database.dart';

final newsDatabaseProvider = Provider<NewsDatabase>((ref) {
  return NewsDatabase(ref);
});

final newsProvider = StreamProvider<List<News>>((ref) {
  final database = ref.watch(newsDatabaseProvider);
  return database.watchNewss();
});
