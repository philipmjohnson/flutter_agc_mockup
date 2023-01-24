import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../async_value_widget.dart';
import '../../chapter/data/chapter_provider.dart';
import '../../chapter/domain/chapter.dart';
import '../../chapter/domain/chapter_collection.dart';
import '../../garden/data/garden_provider.dart';
import '../../garden/domain/garden.dart';
import '../../garden/domain/garden_collection.dart';
import '../../news/domain/news.dart';
import '../domain/user.dart';
import 'user_avatar.dart';

// A Card that summarizes information about a User.
class UserCardView extends ConsumerWidget {
  const UserCardView({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Chapter>> asyncChapters = ref.watch(chaptersProvider);
    final AsyncValue<List<Garden>> asyncGardens = ref.watch(gardensProvider);
    return MultiAsyncValuesWidget(
        asyncChapters: asyncChapters, asyncGardens: asyncGardens, data: _build);
  }

  Widget _build(
      {String? currentUserID,
      List<Chapter>? chapters,
      List<Garden>? gardens,
      List<News>? news,
      List<User>? users}) {
    final GardenCollection gardenCollection = GardenCollection(gardens);
    final ChapterCollection chapterCollection = ChapterCollection(chapters);
    List<String> gardenNames = gardenCollection
        .getAssociatedGardenIDs(userID: user.id)
        .map((gardenID) => gardenCollection.getGarden(gardenID))
        .map((gardenData) => gardenData.name)
        .toList();
    List<String> chapterNames = chapterCollection
        .getAssociatedChapterIDs(user.id, gardenCollection)
        .map((chapterID) => chapterCollection.getChapter(chapterID))
        .map((chapterData) => chapterData.name)
        .toList();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          elevation: 8,
          child: Column(
            children: [
              ListTile(
                  leading: UserAvatar(userID: user.id),
                  trailing: const Icon(Icons.more_vert),
                  title: Text(user.username)),
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
//
//   Widget _buildUserCardView({gardens}) {
//     final GardenDB gardenDB = ref.watch(gardenDBProvider);
//     final ChapterDB chapterDB = ref.watch(chapterDBProvider);
//     List<String> gardenNames = gardenDB
//         .getAssociatedGardenIDs(userID: user.id)
//         .map((gardenID) => gardenDB.getGarden(gardenID))
//         .map((gardenData) => gardenData.name)
//         .toList();
//     List<String> chapterNames = chapterDB
//         .getAssociatedChapterIDs(user.id)
//         .map((chapterID) => chapterDB.getChapter(chapterID))
//         .map((chapterData) => chapterData.name)
//         .toList();
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Card(
//           elevation: 8,
//           child: Column(
//             children: [
//               ListTile(
//                   leading: UserAvatar(userID: user.id),
//                   trailing: const Icon(Icons.more_vert),
//                   title: Text(user.username,
//                       style: Theme.of(context).textTheme.headline6)),
//               Padding(
//                 padding: const EdgeInsets.only(left: 15.0),
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text('Garden(s): ${gardenNames.join(", ")}')),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 15.0),
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text('Chapter(s): ${chapterNames.join(", ")}')),
//               ),
//               const SizedBox(height: 10)
//             ],
//           )),
//     );
//   }
// }

// A Card that summarizes information about a User.
// class UserCardView extends ConsumerWidget {
//   const UserCardView({Key? key, required this.userID}) : super(key: key);
//
//   final String userID;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final UserDB userDB = ref.watch(userDBProvider);
//     final GardenDB gardenDB = ref.watch(gardenDBProvider);
//     final ChapterDB chapterDB = ref.watch(chapterDBProvider);
//     UserData data = userDB.getUser(userID);
//     List<String> gardenNames = gardenDB
//         .getAssociatedGardenIDs(userID: userID)
//         .map((gardenID) => gardenDB.getGarden(gardenID))
//         .map((gardenData) => gardenData.name)
//         .toList();
//     List<String> chapterNames = chapterDB
//         .getAssociatedChapterIDs(userID)
//         .map((chapterID) => chapterDB.getChapter(chapterID))
//         .map((chapterData) => chapterData.name)
//         .toList();
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Card(
//           elevation: 8,
//           child: Column(
//             children: [
//               ListTile(
//                   leading: UserAvatar(userID: userID),
//                   trailing: const Icon(Icons.more_vert),
//                   title: Text(data.username,
//                       style: Theme.of(context).textTheme.headline6)),
//               Padding(
//                 padding: const EdgeInsets.only(left: 15.0),
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text('Garden(s): ${gardenNames.join(", ")}')),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 15.0),
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text('Chapter(s): ${chapterNames.join(", ")}')),
//               ),
//               const SizedBox(height: 10)
//             ],
//           )),
//     );
//   }
// }
