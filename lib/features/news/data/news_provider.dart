import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/news.dart';
import '../domain/news_database.dart';

final newsDatabaseProvider = Provider<NewsDatabase>((ref) {
  return NewsDatabase(ref);
});

final newssStreamProvider = StreamProvider<List<News>>((ref) {
  final database = ref.watch(newsDatabaseProvider);
  return database.watchNewss();
});

final newsProvider = FutureProvider<List<News>>((ref) {
  final database = ref.watch(newsDatabaseProvider);
  return database.fetchNewss();
});
//
// final newsDBProvider = Provider<NewsDB>((ref) {
//   return NewsDB(ref);
// });
