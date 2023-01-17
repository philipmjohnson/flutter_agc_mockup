import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../async_value_widget.dart';
import '../application/user_providers.dart';
import '../domain/user.dart';

/// Provides a CircleAvatar with either an image if available or initials, plus a label.
class UserAvatar extends ConsumerWidget {
  const UserAvatar({Key? key, required this.userID}) : super(key: key);

  final String userID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<User> user = ref.watch(currentUserProvider);
    return AsyncValueWidget<User>(
        value: user,
        data: (user) => (user.imagePath != null)
            ? CircleAvatar(
                backgroundImage: AssetImage(user.imagePath!),
              )
            : CircleAvatar(
                child: Text(user.initials),
              ));
  }
}
