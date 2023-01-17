import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../repositories/firestore/firestore_providers.dart';
import '../domain/user.dart';
import '../domain/user_database.dart';

final userDatabaseProvider = Provider<UserDatabase>((ref) {
  return UserDatabase(ref);
});

final usersStreamProvider = StreamProvider<List<User>>((ref) {
  final database = ref.watch(userDatabaseProvider);
  return database.watchUsers();
});

final currentUserIDProvider = StateProvider<String>((ref) {
  final FirebaseAuth instance = ref.watch(firebaseAuthProvider);
  return instance.currentUser!.email!;
});

final currentUserProvider = FutureProvider<User>((ref) async {
  final String currentUserId = ref.watch(currentUserIDProvider);
  final database = ref.watch(userDatabaseProvider);
  return await database.fetchUser(currentUserId);
});

////////        OLD
// final userDBProvider = Provider<UserDB>((ref) {
//   return UserDB(ref);
// });
