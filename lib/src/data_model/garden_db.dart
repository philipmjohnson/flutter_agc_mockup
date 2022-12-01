import 'chapter_db.dart';
import 'user_db.dart';

/// The data associated with each garden.
class GardenData {
  GardenData(
      {required this.id,
      required this.name,
      required this.description,
      required this.ownerID,
      required this.imagePath,
      required this.chapterID,
      List<String>? editorIDs,
      List<String>? viewerIDs})
      : editorIDs = editorIDs ?? [],
        viewerIDs = viewerIDs ?? [];

  String id;
  String name;
  String description;
  String imagePath;
  String ownerID;
  String chapterID;
  List<String> editorIDs;
  List<String> viewerIDs;
}

/// Provides access to and operations on all defined Gardens.
class GardenDB {
  final List<GardenData> _gardens = [
    GardenData(
        id: 'garden-001',
        name: 'Alderwood Garden',
        description: '19 beds, 162 plantings',
        imagePath: 'assets/images/garden-001.jpg',
        ownerID: 'user-001',
        chapterID: 'chapter-001',
        editorIDs: ['user-002'],
        viewerIDs: ['user-003']),
    GardenData(
        id: 'garden-002',
        name: 'SuperKale Garden',
        description: '17 beds, 149 plantings',
        imagePath: 'assets/images/garden-002.jpg',
        chapterID: 'chapter-001',
        ownerID: 'user-002',
        viewerIDs: ['user-001'])
  ];

  GardenData getGarden(String gardenID) {
    return _gardens.firstWhere((data) => data.id == gardenID);
  }

  List<String> getGardenIDs() {
    return _gardens.map((data) => data.id).toList();
  }

  UserData getOwner(String gardenID) {
    GardenData data = getGarden(gardenID);
    return userDB.getUser(data.ownerID);
  }

  List<UserData> getEditors(String gardenID) {
    GardenData data = getGarden(gardenID);
    return userDB.getUsers(data.editorIDs);
  }

  List<UserData> getViewers(String gardenID) {
    GardenData data = getGarden(gardenID);
    return userDB.getUsers(data.viewerIDs);
  }

  ChapterData getChapter(String gardenID) {
    GardenData data = getGarden(gardenID);
    return chapterDB.getChapter(data.chapterID);
  }
}

/// The singleton instance of a gardenDB used by clients to access garden data.
GardenDB gardenDB = GardenDB();
