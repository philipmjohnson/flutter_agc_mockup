import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/chapter_db.dart';

final chapterDBProvider = Provider<ChapterDB>((ref) {
  return ChapterDB(ref);
});
