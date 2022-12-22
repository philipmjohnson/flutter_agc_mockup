import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../garden/application/garden_provider.dart';
import '../../garden/domain/garden_db.dart';

/// The data associated with each chapter.
class ChapterData {
  ChapterData(
      {required this.id,
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

/// Provides access to and operations on all of the defined Chapters.
/// Depends on GardenDB.
class ChapterDB {
  ChapterDB(this.ref);
  final ProviderRef<ChapterDB> ref;
  final List<ChapterData> _chapters = [
    ChapterData(
        id: 'chapter-001',
        name: 'Bellingham, WA',
        zipCodes: ['98225', '98226', '98227', '98228', '98229'],
        imagePath: 'assets/images/chapter-001.png',
        hardinessZones: ['8a', '8b']),
    ChapterData(
        id: 'chapter-002',
        name: 'Kailua, HI',
        zipCodes: ['98734'],
        imagePath: 'assets/images/chapter-002.png',
        hardinessZones: ['10b', '11a', '11b', '12a', '12b', '13a']),
  ];

  ChapterData getChapter(String chapterID) {
    return _chapters.firstWhere((data) => data.id == chapterID);
  }

  List<String> getChapterIDs() {
    return _chapters.map((data) => data.id).toList();
  }

  List<String> getAssociatedChapterIDs(String userID) {
    final GardenDB gardenDB = ref.watch(gardenDBProvider);
    List<String> gardenIDs = gardenDB.getAssociatedGardenIDs(userID: userID);
    Set<String> chapterIDs = {};
    for (var gardenID in gardenIDs) {
      chapterIDs.add(gardenDB.getGarden(gardenID).chapterID);
    }
    return chapterIDs.toList();
  }

  List<String> getAssociatedUserIDs(String chapterID) {
    final GardenDB gardenDB = ref.watch(gardenDBProvider);
    List<String> gardenIDs =
        gardenDB.getAssociatedGardenIDs(chapterID: chapterID);
    Set<String> userIDs = {};
    for (var gardenID in gardenIDs) {
      userIDs.addAll(gardenDB.getAssociatedUserIDs(gardenID));
    }
    return userIDs.toList();
  }

  List<String> getChapterNames() {
    return _chapters.map((chapter) => chapter.name).toList();
  }

  String getChapterIDFromName(String name) {
    return _chapters.firstWhere((chapter) => chapter.name == name).id;
  }

  ChapterData getChapterFromGardenID(String gardenID) {
    final gardenDB = ref.watch(gardenDBProvider);
    GardenData data = gardenDB.getGarden(gardenID);
    return getChapter(data.chapterID);
  }

  // Return the userIDs of users who are in the same Chapter(s) as [userID].
  // First, get all of the chapterIDs that this [userID] is associated with.
  // Then build the set of all userIDs associated with the chapterIDs.
  List<String> getAssociatedUserIDsOfUserID(String userID) {
    List<String> chapterIDs = getAssociatedChapterIDs(userID);
    Set<String> userIDs = {};
    for (var chapterID in chapterIDs) {
      userIDs.addAll(getAssociatedUserIDs(chapterID));
    }
    return userIDs.toList();
  }
}
