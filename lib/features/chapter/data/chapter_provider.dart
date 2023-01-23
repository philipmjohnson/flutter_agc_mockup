import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/chapter.dart';
import 'chapter_database.dart';

final chapterDatabaseProvider = Provider<ChapterDatabase>((ref) {
  return ChapterDatabase(ref);
});

final chaptersStreamProvider = StreamProvider<List<Chapter>>((ref) {
  final database = ref.watch(chapterDatabaseProvider);
  return database.watchChapters();
});

final chaptersProvider = FutureProvider<List<Chapter>>((ref) {
  final database = ref.watch(chapterDatabaseProvider);
  return database.fetchChapters();
});

/// OLD
// final chapterDBProvider = Provider<ChapterDB>((ref) {
//   return ChapterDB(ref);
// });
