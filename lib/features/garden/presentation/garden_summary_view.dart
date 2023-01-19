import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../chapter/application/chapter_provider.dart';
import '../../chapter/domain/chapter_db.dart';
import '../domain/garden.dart';
import 'edit_garden_view2.dart';
import 'garden_summary_users_view.dart';

enum GardenAction { edit, leave }

/// Provides a Card summarizing a garden.
class GardenSummaryView extends ConsumerWidget {
  const GardenSummaryView({Key? key, required this.garden}) : super(key: key);

  final Garden garden;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ChapterDB chapterDB = ref.watch(chapterDBProvider);
    String title = garden.name;
    String subtitle = garden.description;
    String lastUpdate = garden.lastUpdate;
    String imagePath = garden.imagePath;
    String chapterName = chapterDB.getChapterFromGardenID(garden.id).name;
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
                      arguments: garden.id);
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
          GardenSummaryUsersView(gardenID: garden.id),
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
