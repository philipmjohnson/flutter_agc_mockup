import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../garden/application/garden_provider.dart';
import '../../garden/domain/garden_db.dart';
import '../application/chapter_provider.dart';
import '../domain/chapter_db.dart';

/// Provides a Card that summarizes a Chapter.
class ChapterCardView extends ConsumerWidget {
  const ChapterCardView({Key? key, required this.chapterID}) : super(key: key);

  final String chapterID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ChapterDB chapterDB = ref.watch(chapterDBProvider);
    final GardenDB gardenDB = ref.watch(gardenDBProvider);
    ChapterData data = chapterDB.getChapter(chapterID);
    int numGardens =
        gardenDB.getAssociatedGardenIDs(chapterID: chapterID).length;
    int numMembers = chapterDB.getAssociatedUserIDs(chapterID).length;
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
