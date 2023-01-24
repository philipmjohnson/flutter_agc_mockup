import '../../garden/domain/garden.dart';
import '../../garden/domain/garden_collection.dart';
import '../../user/domain/user.dart';
import '../../user/domain/user_collection.dart';
import 'chapter.dart';

/// Encapsulates operations on the list of [Chapter] returned from Firestore.
class ChapterCollection {
  ChapterCollection(chapters) : _chapters = chapters;

  final List<Chapter> _chapters;

  int size() {
    return _chapters.length;
  }

  Chapter getChapter(String chapterID) {
    return _chapters.firstWhere((data) => data.id == chapterID);
  }

  List<String> getChapterIDs() {
    return _chapters.map((data) => data.id).toList();
  }

  List<String> getAssociatedChapterIDs(
      String userID, GardenCollection gardenCollection) {
    List<String> gardenIDs =
        gardenCollection.getAssociatedGardenIDs(userID: userID);
    Set<String> chapterIDs = {};
    for (var gardenID in gardenIDs) {
      chapterIDs.add(gardenCollection.getGarden(gardenID).chapterID);
    }
    return chapterIDs.toList();
  }

  List<String> getAssociatedUserIDs(
      String chapterID, GardenCollection gardenCollection) {
    List<String> gardenIDs =
        gardenCollection.getAssociatedGardenIDs(chapterID: chapterID);
    Set<String> userIDs = {};
    for (var gardenID in gardenIDs) {
      userIDs.addAll(gardenCollection.getAssociatedUserIDs(gardenID));
    }
    return userIDs.toList();
  }

  List<String> getChapterNames() {
    return _chapters.map((chapter) => chapter.name).toList();
  }

  String getChapterIDFromName(String name) {
    return _chapters.firstWhere((chapter) => chapter.name == name).id;
  }

  Chapter getChapterFromGardenID(
      String gardenID, GardenCollection gardenCollection) {
    Garden data = gardenCollection.getGarden(gardenID);
    return getChapter(data.chapterID);
  }

  // Return the userIDs of users who are in the same Chapter(s) as [userID].
  // First, get all of the chapterIDs that this [userID] is associated with.
  // Then build the set of all userIDs associated with the chapterIDs.
  List<String> getAssociatedUserIDsOfUserID(
      String userID, GardenCollection gardenCollection) {
    List<String> chapterIDs = getAssociatedChapterIDs(userID, gardenCollection);
    Set<String> userIDs = {};
    for (var chapterID in chapterIDs) {
      userIDs.addAll(getAssociatedUserIDs(chapterID, gardenCollection));
    }
    return userIDs.toList();
  }

  // Return the user instances of users who are in the same Chapter(s) as [userID].
  // First, get all of the chapterIDs that this [userID] is associated with.
  // Then build the set of all user instances associated with the chapterIDs.
  List<User> getAssociatedUsersOfUserID(String userID,
      GardenCollection gardenCollection, UserCollection userCollection) {
    List<String> chapterIDs = getAssociatedChapterIDs(userID, gardenCollection);
    Set<String> userIDs = {};
    for (var chapterID in chapterIDs) {
      userIDs.addAll(getAssociatedUserIDs(chapterID, gardenCollection));
    }
    return userIDs.map((userID) => userCollection.getUser(userID)).toList();
  }
}
