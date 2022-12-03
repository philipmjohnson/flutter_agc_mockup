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
      required this.lastUpdate,
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
  String lastUpdate;
  List<String> editorIDs;
  List<String> viewerIDs;
}

/// Provides access to and operations on all defined Gardens.
class GardenDB {
  final List<GardenData> _gardens = [
    GardenData(
        id: 'garden-001',
        name: 'Alderwood Hill',
        description: '19 beds, 162 plantings (2022)',
        imagePath: 'assets/images/garden-001.jpg',
        ownerID: 'user-001',
        chapterID: 'chapter-001',
        lastUpdate: '11/15/22',
        editorIDs: ['user-002'],
        viewerIDs: ['user-003', 'user-005']),
    GardenData(
        id: 'garden-002',
        name: 'Kale is for Kids',
        description: '17 beds, 149 plantings (2022)',
        imagePath: 'assets/images/garden-002.jpg',
        chapterID: 'chapter-001',
        lastUpdate: '10/10/22',
        ownerID: 'user-002',
        viewerIDs: ['user-001', 'user-005']),
    GardenData(
        id: 'garden-003',
        name: 'Kaimake Loop',
        description: '1 beds, 5 plantings (2022)',
        imagePath: 'assets/images/garden-003.jpg',
        chapterID: 'chapter-002',
        lastUpdate: '8/10/22',
        ownerID: 'user-004',
        viewerIDs: ['user-005'],
        editorIDs: ['user-003'])
  ];

  GardenData getGarden(String gardenID) {
    return _gardens.firstWhere((data) => data.id == gardenID);
  }

  List<String> getGardenIDs() {
    return _gardens.map((data) => data.id).toList();
  }

  List<String> getAssociatedGardenIDs({String? userID, String? chapterID}) {
    if (userID != null) {
      return getGardenIDs()
          .where((gardenID) => _userIsAssociated(gardenID, userID))
          .toList();
    }
    if (chapterID != null) {
      return getGardenIDs()
          .where((gardenID) => getGarden(gardenID).chapterID == chapterID)
          .toList();
    }
    return [];
  }

  List<String> getAssociatedUserIDs(gardenID) {
    GardenData data = gardenDB.getGarden(gardenID);
    return [
      data.ownerID,
      ...data.viewerIDs,
      ...data.editorIDs
    ];
  }

  bool _userIsAssociated(String gardenID, String userID) {
    GardenData data = getGarden(gardenID);
    return ((data.ownerID == userID) ||
        (data.viewerIDs.contains(userID)) ||
        (data.editorIDs.contains(userID)));
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
