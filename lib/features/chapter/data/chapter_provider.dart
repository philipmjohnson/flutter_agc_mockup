import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/chapter.dart';
import 'chapter_database.dart';

/// Riverpod provider for [ChapterDatabase].
final chapterDatabaseProvider = Provider<ChapterDatabase>((ref) {
  return ChapterDatabase(ref);
});

/// Riverpod provider for the current list of [Chapter].
final chaptersProvider = StreamProvider<List<Chapter>>((ref) {
  final database = ref.watch(chapterDatabaseProvider);
  return database.watchChapters();
});
