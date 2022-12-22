import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../user/application/user_providers.dart';
import '../../user/domain/user_db.dart';

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

  @override
  String toString() {
    return '<GardenData id: $id, name: $name, description: $description, imagePath: $imagePath, ownerID: $ownerID, chapterID: $chapterID, lastUpdate: $lastUpdate, editorIDs: ${editorIDs.toString()}, viewerIDs: ${viewerIDs.toString()}>';
  }
}

/// Provides access to and operations on all defined Gardens.
/// Depends on UserDB.
class GardenDB {
  GardenDB(this.ref);

  final ProviderRef<GardenDB> ref;
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

  void addGarden(
      {required String name,
      required String description,
      required String imageFileName,
      required String chapterID,
      required String ownerID,
      required List<String> viewerIDs,
      required List<String> editorIDs}) {
    String id = 'garden-${(_gardens.length + 1).toString().padLeft(3, '0')}';
    String imagePath = 'assets/images/$imageFileName';
    String lastUpdate = DateFormat.yMd().format(DateTime.now());
    GardenData data = GardenData(
        id: id,
        name: name,
        description: description,
        imagePath: imagePath,
        chapterID: chapterID,
        lastUpdate: lastUpdate,
        ownerID: ownerID,
        viewerIDs: viewerIDs,
        editorIDs: editorIDs);
    _gardens.add(data);
  }

  void updateGarden(
      {required String id,
      required String name,
      required String description,
      required String imagePath,
      required String chapterID,
      required String ownerID,
      required List<String> viewerIDs,
      required List<String> editorIDs}) {
    // first remove the current GardenData instance.
    _gardens.removeWhere((gardenData) => gardenData.id == id);
    // now add the updated version
    String lastUpdate = DateFormat.yMd().format(DateTime.now());
    GardenData data = GardenData(
        id: id,
        name: name,
        description: description,
        imagePath: imagePath,
        chapterID: chapterID,
        lastUpdate: lastUpdate,
        ownerID: ownerID,
        viewerIDs: viewerIDs,
        editorIDs: editorIDs);
    _gardens.add(data);
  }

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
    GardenData data = getGarden(gardenID);
    return [data.ownerID, ...data.viewerIDs, ...data.editorIDs];
  }

  bool _userIsAssociated(String gardenID, String userID) {
    GardenData data = getGarden(gardenID);
    return ((data.ownerID == userID) ||
        (data.viewerIDs.contains(userID)) ||
        (data.editorIDs.contains(userID)));
  }

  UserData getOwner(String gardenID) {
    GardenData data = getGarden(gardenID);
    UserDB userDB = ref.read(userDBProvider);
    return userDB.getUser(data.ownerID);
  }

  List<UserData> getEditors(String gardenID) {
    GardenData data = getGarden(gardenID);
    UserDB userDB = ref.read(userDBProvider);
    return userDB.getUsers(data.editorIDs);
  }

  List<UserData> getViewers(String gardenID) {
    GardenData data = getGarden(gardenID);
    UserDB userDB = ref.read(userDBProvider);
    return userDB.getUsers(data.viewerIDs);
  }
}
