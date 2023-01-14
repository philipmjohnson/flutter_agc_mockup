import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/user.dart';
import '../domain/user_database.dart';
import '../domain/user_db.dart';

final userDatabaseProvider = Provider<UserDatabase>((ref) {
  return UserDatabase(ref);
});

final usersStreamProvider = StreamProvider<List<User>>((ref) {
  final database = ref.watch(userDatabaseProvider);
  return database.watchUsers();
});

////////        OLD
final userDBProvider = Provider<UserDB>((ref) {
  return UserDB(ref);
});

final currentUserIDProvider = StateProvider<String>((ref) {
  return 'user-001';
});
