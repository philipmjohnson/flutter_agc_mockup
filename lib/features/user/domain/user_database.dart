import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../repositories/firestore/firestore_path.dart';
import '../../../repositories/firestore/firestore_service.dart';
import 'user.dart';

class UserDatabase {
  UserDatabase(this.ref);

  final ProviderRef<UserDatabase> ref;

  final _service = FirestoreService.instance;

  Stream<List<User>> watchUsers() => _service.watchCollection(
      path: FirestorePath.users(),
      builder: (data, documentId) => User.fromFirestore(data!, documentId));

  Stream<User> watchUser(String userId) => _service.watchDocument(
      path: FirestorePath.user(userId),
      builder: (data, documentId) => User.fromFirestore(data!, documentId));

  Future<List<User>> fetchUsers() => _service.fetchCollection(
      path: FirestorePath.users(),
      builder: (data, documentId) => User.fromFirestore(data!, documentId));

  Future<User> fetchUser(String userId) => _service.fetchDocument(
      path: FirestorePath.user(userId),
      builder: (data, documentId) => User.fromFirestore(data!, documentId));

  Future<void> setUser(User user) =>
      _service.setData(path: FirestorePath.user("foo"), data: user.toJson());

  static User getUser(List<User> users, String userID) {
    return users.firstWhere((userData) => userData.id == userID);
  }

  static bool areUserNames(List<User> users, List<String> userNames) {
    List<String> allUserNames =
        users.map((userData) => userData.username).toList();
    return userNames.every((userName) => allUserNames.contains(userName));
  }

  static String getUserID(List<User> users, String emailOrUsername) {
    return (emailOrUsername.startsWith('@'))
        ? users
            .firstWhere((userData) => userData.username == emailOrUsername)
            .id
        : users.firstWhere((userData) => userData.id == emailOrUsername).id;
  }
}
