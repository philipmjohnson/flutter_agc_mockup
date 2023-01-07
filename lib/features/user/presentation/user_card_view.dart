import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../chapter/application/chapter_provider.dart';
import '../../chapter/domain/chapter_db.dart';
import '../../garden/application/garden_provider.dart';
import '../../garden/domain/garden_db.dart';
import '../application/user_providers.dart';
import '../domain/user_db.dart';
import 'user_avatar.dart';

// A Card that summarizes information about a User.
class UserCardView extends ConsumerWidget {
  const UserCardView({Key? key, required this.userID}) : super(key: key);

  final String userID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserDB userDB = ref.watch(userDBProvider);
    final GardenDB gardenDB = ref.watch(gardenDBProvider);
    final ChapterDB chapterDB = ref.watch(chapterDBProvider);
    UserData data = userDB.getUser(userID);
    List<String> gardenNames = gardenDB
        .getAssociatedGardenIDs(userID: userID)
        .map((gardenID) => gardenDB.getGarden(gardenID))
        .map((gardenData) => gardenData.name)
        .toList();
    List<String> chapterNames = chapterDB
        .getAssociatedChapterIDs(userID)
        .map((chapterID) => chapterDB.getChapter(chapterID))
        .map((chapterData) => chapterData.name)
        .toList();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          elevation: 8,
          child: Column(
            children: [
              ListTile(
                  leading: UserAvatar(userID: userID),
                  trailing: const Icon(Icons.more_vert),
                  title: Text(data.username,
                      style: Theme.of(context).textTheme.headline6)),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Garden(s): ${gardenNames.join(", ")}')),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Chapter(s): ${chapterNames.join(", ")}')),
              ),
              const SizedBox(height: 10)
            ],
          )),
    );
  }
}
