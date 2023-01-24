import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../async_value_widget.dart';
import '../../garden/data/garden_provider.dart';
import '../../garden/domain/garden.dart';
import '../../garden/domain/garden_collection.dart';
import '../../news/domain/news.dart';
import '../../user/data/user_providers.dart';
import '../../user/domain/user.dart';
import '../data/chapter_provider.dart';
import '../domain/chapter.dart';
import '../domain/chapter_collection.dart';

/// Builds a Card that summarizes a Chapter.
class ChapterCardView extends ConsumerWidget {
  const ChapterCardView({Key? key, required this.chapterID}) : super(key: key);

  final String chapterID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String currentUserID = ref.watch(currentUserIDProvider);
    final AsyncValue<List<Chapter>> asyncChapters = ref.watch(chaptersProvider);
    final AsyncValue<List<Garden>> asyncGardens = ref.watch(gardensProvider);
    return MultiAsyncValuesWidget(
        context: context,
        currentUserID: currentUserID,
        asyncChapters: asyncChapters,
        asyncGardens: asyncGardens,
        data: _build);
  }

  Widget _build(
      {required BuildContext context,
      required String currentUserID,
      List<Chapter>? chapters,
      List<Garden>? gardens,
      List<News>? news,
      List<User>? users}) {
    ChapterCollection chapterCollection = ChapterCollection(chapters);
    GardenCollection gardenCollection = GardenCollection(gardens);
    Chapter data = chapterCollection.getChapter(chapterID);
    int numGardens =
        gardenCollection.getAssociatedGardenIDs(chapterID: chapterID).length;
    int numMembers = chapterCollection
        .getAssociatedUserIDs(chapterID, gardenCollection)
        .length;
    List<String> zipCodes = data.zipCodes;
    AssetImage image = AssetImage(data.imagePath);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          elevation: 8,
          child: Column(
            children: [
              ListTile(
                  trailing: const Icon(Icons.more_vert),
                  title: Text('${data.name} Chapter',
                      style: Theme.of(context).textTheme.headline6)),
              const SizedBox(height: 10),
              SizedBox(
                height: 150.0,
                child: Ink.image(
                  image: image,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Number of Gardens: $numGardens')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Number of Members: $numMembers')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Zip Codes: ${zipCodes.join(", ")}')),
              )
            ],
          )),
    );
  }
}
