/// The data associated with users.
class UserData {
  UserData(
      {required this.id,
      required this.name,
      required this.email,
      this.imagePath,
      required this.initials});

  String id;
  String name;
  String email;
  String? imagePath;
  String initials;
}

/// Provides access to and operations on all defined users.
class UserDB {
  final List<UserData> _users = [
    UserData(
        id: 'user-001',
        name: 'Jenna Deane',
        email: 'jennacorindeane@gmail.com',
        imagePath: 'assets/images/jenna-deane.jpg',
        initials: 'JD'),
    UserData(
        id: 'user-002',
        name: 'Jesse Beck',
        email: 'jessebeck@gmail.com',
        initials: 'JB'),
    UserData(
        id: 'user-003',
        name: 'Joanne Amberg',
        email: 'joanne.amberg@gmail.com',
        initials: 'JA'),
    UserData(
        id: 'user-004',
        name: 'Philip Johnson',
        email: 'johnson@hawaii.edu',
        initials: 'PJ')
  ];

  UserData getUser(String userID) {
    return _users.firstWhere((userData) => userData.id == userID);
  }

  List<UserData> getUsers(List<String> userIDs) {
    return _users.where((userData) => userIDs.contains(userData.id)).toList();
  }
}

/// The singleton instance providing access to all user data for clients.
UserDB userDB = UserDB();

/// The currently logged in user.
String currentUserID = 'user-004';
