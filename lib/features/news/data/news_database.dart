import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../repositories/firestore/firestore_path.dart';
import '../../../repositories/firestore/firestore_service.dart';
import '../domain/news.dart';

// Provides access to the Firestore database storing [News] documents.
class NewsDatabase {
  NewsDatabase(this.ref);

  final ProviderRef<NewsDatabase> ref;

  final _service = FirestoreService.instance;

  Stream<List<News>> watchNewss() => _service.watchCollection(
      path: FirestorePath.newss(),
      builder: (data, documentId) => News.fromJson(data!));

  Stream<News> watchNews(String newsID) => _service.watchDocument(
      path: FirestorePath.news(newsID),
      builder: (data, documentId) => News.fromJson(data!));

  Future<List<News>> fetchNewss() => _service.fetchCollection(
      path: FirestorePath.newss(),
      builder: (data, documentId) => News.fromJson(data!));

  Future<News> fetchNews(String newsId) => _service.fetchDocument(
      path: FirestorePath.news(newsId),
      builder: (data, documentId) => News.fromJson(data!));

  Future<void> setNews(News news) =>
      _service.setData(path: FirestorePath.news(news.id), data: news.toJson());
}
