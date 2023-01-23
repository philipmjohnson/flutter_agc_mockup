import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../repositories/firestore/firestore_path.dart';
import '../../../repositories/firestore/firestore_service.dart';
import '../domain/chapter.dart';

/// Provides access to the Firestore database storing Chapter documents.
class ChapterDatabase {
  ChapterDatabase(this.ref);

  final ProviderRef<ChapterDatabase> ref;

  final _service = FirestoreService.instance;

  Stream<List<Chapter>> watchChapters() => _service.watchCollection(
      path: FirestorePath.chapters(),
      builder: (data, documentId) => Chapter.fromJson(data!));

  Stream<Chapter> watchChapter(String chapterId) => _service.watchDocument(
      path: FirestorePath.chapter(chapterId),
      builder: (data, documentId) => Chapter.fromJson(data!));

  Future<List<Chapter>> fetchChapters() => _service.fetchCollection(
      path: FirestorePath.chapters(),
      builder: (data, documentId) => Chapter.fromJson(data!));

  Future<Chapter> fetchChapter(String chapterId) => _service.fetchDocument(
      path: FirestorePath.chapter(chapterId),
      builder: (data, documentId) => Chapter.fromJson(data!));

  Future<void> setChapter(Chapter chapter) => _service.setData(
      path: FirestorePath.chapter(chapter.id), data: chapter.toJson());
}
