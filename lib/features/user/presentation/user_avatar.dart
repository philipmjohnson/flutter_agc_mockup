import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/user_providers.dart';
import '../domain/user_db.dart';

/// Provides a CircleAvatar with either an image if available or initials, plus a label.
class UserAvatar extends ConsumerWidget {
  const UserAvatar({Key? key, required this.userID}) : super(key: key);

  final String userID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserDB userDB = ref.watch(userDBProvider);
    UserData data = userDB.getUser(userID);
    bool hasImagePath = data.imagePath != null;
    return
      (hasImagePath) ?
      CircleAvatar(
        backgroundImage: AssetImage(data.imagePath!),
      ) :
      CircleAvatar(
        child: Text(data.initials),
      );
  }
}
