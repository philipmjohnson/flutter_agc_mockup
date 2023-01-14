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

  Future<void> setUser(User user) =>
      _service.setData(path: FirestorePath.user("foo"), data: user.toJson());
}
