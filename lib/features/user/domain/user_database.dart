import '../../../repositories/firestore/firestore_path.dart';
import '../../../repositories/firestore/firestore_service.dart';
import 'user.dart';

class UserDatabase {
  UserDatabase({required this.uid});

  final String uid;

  final _service = FirestoreService.instance;

  void testUser() {
    User newUser = const User(
        id: 'foo',
        name: 'bar',
        username: 'baz',
        imagePath: 'qux',
        initials: 'pj');
    String email = newUser.id;
  }

  Stream<List<User>> watchUsers() => _service.watchCollection(
      path: FirestorePath.users(),
      builder: (data, documentId) => User.fromFirestore(data!, documentId));

  Future<void> setUser(User user) =>
      _service.setData(path: FirestorePath.user("foo"), data: user.toJson());
}
