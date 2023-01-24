import 'garden.dart';

// After retrieving a snapshot of the Gardens collection from Firestore, this
// class encapsulates common operations on it.
class GardenCollection {
  GardenCollection(gardens) : _gardens = gardens;

  final List<Garden> _gardens;

  Garden getGarden(String gardenID) {
    return _gardens.firstWhere((data) => data.id == gardenID);
  }

  int size() {
    return _gardens.length;
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

  List<Garden> getAssociatedGardens({String? userID, String? chapterID}) {
    if (userID != null) {
      return _gardens
          .where((garden) => _userIsAssociated(garden.id, userID))
          .toList();
    }
    if (chapterID != null) {
      return _gardens.where((garden) => garden.chapterID == chapterID).toList();
    }
    return [];
  }

  List<String> getAssociatedUserIDs(gardenID) {
    Garden data = getGarden(gardenID);
    return [data.ownerID, ...data.viewerIDs, ...data.editorIDs];
  }

  bool _userIsAssociated(String gardenID, String userID) {
    Garden data = getGarden(gardenID);
    return ((data.ownerID == userID) ||
        (data.viewerIDs.contains(userID)) ||
        (data.editorIDs.contains(userID)));
  }
}
