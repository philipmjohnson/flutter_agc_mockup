import 'user_db.dart';

/// The data associated with each chapter.
class ChapterData {
  ChapterData({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.hardinessZones,
    required this.zipCodes});

  String id;
  String name;
  String imagePath;
  List<String> zipCodes;
  List<String> hardinessZones;
}

/// Provides access to and operations on all defined Chapters.
class ChapterDB {
  final List<ChapterData> _chapters = [
    ChapterData(
        id: 'chapter-001',
        name: 'Bellingham, WA',
        zipCodes: ['98225', '98226', '98227', '98228', '98229'],
        imagePath: 'assets/images/chapter-001.png',
        hardinessZones: ['Zone 8a', 'Zone 8b']
        ),
    ChapterData(
        id: 'chapter-002',
        name: 'Kailua, HI',
        zipCodes: ['98734'],
        imagePath: 'assets/images/bellingham-chapter-map.jpg',
        hardinessZones: ['Zone 8a', 'Zone 8b']
    ),
  ];

  ChapterData getChapter(String ChapterID) {
    return _chapters.firstWhere((data) => data.id == ChapterID);
  }

  List<String> getChapterIDs() {
    return _chapters.map((data) => data.id).toList();
  }
}

/// The singleton instance of a ChapterDB used by clients to access Chapter data.
ChapterDB chapterDB = ChapterDB();
