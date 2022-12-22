import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../chapter/application/chapter_provider.dart';
import '../../chapter/domain/chapter_db.dart';
import '../../garden/presentation/garden_summary_users_view.dart';
import '../application/garden_provider.dart';
import '../domain/garden_db.dart';
import 'edit_garden_view.dart';

enum GardenAction { edit, leave }

/// Provides a Card summarizing a garden.
class GardenSummaryView extends ConsumerWidget {
  const GardenSummaryView({Key? key, required this.gardenID}) : super(key: key);

  final String gardenID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GardenDB gardenDB = ref.watch(gardenDBProvider);
    final ChapterDB chapterDB = ref.watch(chapterDBProvider);
    GardenData gardenData = gardenDB.getGarden(gardenID);
    String title = gardenData.name;
    String subtitle = gardenData.description;
    String lastUpdate = gardenData.lastUpdate;
    String imagePath = gardenData.imagePath;
    String chapterName = chapterDB.getChapterFromGardenID(gardenID).name;
    AssetImage image = AssetImage(imagePath);
    return Card(
      elevation: 9,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            isThreeLine: true,
            title: Text(title),
            subtitle: Text('$subtitle\n$chapterName Chapter'),
            trailing: PopupMenuButton<GardenAction>(
              // Callback that sets the selected popup menu item.
              onSelected: (GardenAction action) {
                if (action == GardenAction.edit) {
                  Navigator.restorablePushNamed(
                      context, EditGardenView.routeName,
                      arguments: gardenID);
                }
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<GardenAction>>[
                const PopupMenuItem<GardenAction>(
                  value: GardenAction.edit,
                  child: Text('Edit'),
                ),
                const PopupMenuItem<GardenAction>(
                  value: GardenAction.leave,
                  child: Text('Leave'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 150.0,
            child: Ink.image(
              image: image,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          GardenSummaryUsersView(gardenID: gardenID),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.centerRight,
                child: Text('Last updated: $lastUpdate')),
          ),
        ],
      ),
    );
  }
}
