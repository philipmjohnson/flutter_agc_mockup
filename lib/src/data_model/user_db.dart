import 'chapter_db.dart';

/// The data associated with users.
class UserData {
  UserData(
      {required this.id,
      required this.name,
      required this.email,
      required this.username,
      this.imagePath,
      required this.initials});

  String id;
  String name;
  String email;
  String username;
  String? imagePath;
  String initials;
}

/// Provides access to and operations on all defined users.
class UserDB {
  final List<UserData> _users = [
    UserData(
        id: 'user-001',
        name: 'Jenna Deane',
        username: '@fluke',
        email: 'jennacorindeane@gmail.com',
        imagePath: 'assets/images/jenna-deane.jpg',
        initials: 'JD'),
    UserData(
        id: 'user-002',
        name: 'Jesse Beck',
        username: '@jesse',
        email: 'jessebeck@gmail.com',
        initials: 'JB'),
    UserData(
        id: 'user-003',
        name: 'Joanne Amberg',
        username: '@joanne',
        email: 'joanne.amberg@gmail.com',
        initials: 'JA'),
    UserData(
        id: 'user-004',
        name: 'Philip Johnson',
        username: '@fiveclockphil',
        email: 'johnson@hawaii.edu',
        initials: 'PJ')
  ];

  UserData getUser(String userID) {
    return _users.firstWhere((userData) => userData.id == userID);
  }

  List<UserData> getUsers(List<String> userIDs) {
    return _users.where((userData) => userIDs.contains(userData.id)).toList();
  }

  // Return the userIDs of users who are in the same Chapter(s) as [userID].
  // First, get all of the chapterIDs that this [userID] is associated with.
  // Then build the set of all userIDs associated with the chapterIDs.
  List<String> getAssociatedUserIDs(String userID) {
    List<String> chapterIDs = chapterDB.getAssociatedChapterIDs(userID);
    print(chapterIDs);
    Set<String> userIDs = {};
    chapterIDs.forEach((chapterID) => userIDs.addAll(chapterDB.getAssociatedUserIDs(chapterID)));
    return userIDs.toList();
  }
}

/// The singleton instance providing access to all user data for clients.
UserDB userDB = UserDB();

/// The currently logged in user.
String currentUserID = 'user-001';