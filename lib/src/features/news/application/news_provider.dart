import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/news_db.dart';

final newsDBProvider = Provider<NewsDB>((ref) {
  return NewsDB(ref);
});
