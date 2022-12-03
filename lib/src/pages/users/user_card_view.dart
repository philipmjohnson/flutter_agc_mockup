import 'package:flutter/material.dart';
import '../../components/user_avatar.dart';
import '../../data_model/chapter_db.dart';
import '../../data_model/garden_db.dart';
import '../../data_model/user_db.dart';

class UserCardView extends StatelessWidget {
  const UserCardView({Key? key, required this.userID}) : super(key: key);

  final String userID;

  @override
  Widget build(BuildContext context) {
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
