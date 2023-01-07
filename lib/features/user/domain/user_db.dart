import 'package:flutter_riverpod/flutter_riverpod.dart';

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
/// Does not depend on any other DBs.
class UserDB {
  UserDB(this.ref);

  final ProviderRef<UserDB> ref;
  final List<UserData> _users = [
    UserData(
        id: 'user-001',
        name: 'Jenna Deane',
        username: '@fluke',
        email: 'jennacorindeane@gmail.com',
        imagePath: 'assets/images/user-001.jpg',
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
        username: '@fiveoclockphil',
        email: 'johnson@hawaii.edu',
        initials: 'PJ'),
    UserData(
        id: 'user-005',
        name: 'Katie Amberg-Johnson',
        username: '@katiekai',
        email: 'katieambergjohnson@gmail.com',
        imagePath: 'assets/images/user-005.jpg',
        initials: 'KAJ')
  ];

  UserData getUser(String userID) {
    return _users.firstWhere((userData) => userData.id == userID);
  }

  bool areUserNames(List<String> userNames) {
    List<String> allUserNames =
        _users.map((userData) => userData.username).toList();
    return userNames.every((userName) => allUserNames.contains(userName));
  }

  String getUserID(String emailOrUsername) {
    return (emailOrUsername.startsWith('@'))
        ? _users
            .firstWhere((userData) => userData.username == emailOrUsername)
            .id
        : _users.firstWhere((userData) => userData.email == emailOrUsername).id;
  }

  bool isUserEmail(String email) {
    List<String> emails = _users.map((userData) => userData.email).toList();
    return emails.contains(email);
  }

  List<UserData> getUsers(List<String> userIDs) {
    return _users.where((userData) => userIDs.contains(userData.id)).toList();
  }

  List<String> getAllEmails() {
    return _users.map((userData) => userData.email).toList();
  }
}
