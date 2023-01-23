import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../async_value_widget.dart';
import '../../chapter/domain/chapter.dart';
import '../../garden/domain/garden.dart';
import '../../news/domain/news.dart';
import '../application/user_providers.dart';
import '../domain/user.dart';
import '../domain/user_collection.dart';

/// Provides a CircleAvatar with either an image if available or initials, plus a label.
class UserAvatar extends ConsumerWidget {
  const UserAvatar({Key? key, required this.userID}) : super(key: key);

  final String userID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String currentUserID = ref.watch(currentUserIDProvider);
    final AsyncValue<List<User>> asyncUsers = ref.watch(usersProvider);
    return AsyncValuesAGCWidget(
        currentUserID: currentUserID, asyncUsers: asyncUsers, data: _build);
  }

  Widget _build(
      {String? currentUserID,
      List<Chapter>? chapters,
      List<Garden>? gardens,
      List<News>? news,
      List<User>? users}) {
    UserCollection userCollection = UserCollection(users);
    User user = userCollection.getUser(userID);
    return (user.imagePath != null)
        ? CircleAvatar(
            backgroundImage: AssetImage(user.imagePath!),
          )
        : CircleAvatar(
            child: Text(user.initials),
          );
  }
}
