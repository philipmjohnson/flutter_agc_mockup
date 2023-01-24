import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../async_value_widget.dart';
import '../../chapter/data/chapter_provider.dart';
import '../../chapter/domain/chapter.dart';
import '../../chapter/domain/chapter_collection.dart';
import '../../news/domain/news.dart';
import '../../user/data/user_providers.dart';
import '../../user/domain/user.dart';
import '../data/garden_provider.dart';
import '../domain/garden.dart';
import '../domain/garden_collection.dart';
import 'edit_garden_view.dart';
import 'garden_summary_users_view.dart';

enum GardenAction { edit, leave }

/// Builds a Card summarizing a [Garden].
class GardenSummaryView extends ConsumerWidget {
  const GardenSummaryView({Key? key, required this.garden}) : super(key: key);

  final Garden garden;

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
    String title = garden.name;
    String subtitle = garden.description;
    String lastUpdate = garden.lastUpdate;
    String imagePath = garden.imagePath;
    String chapterName = chapterCollection
        .getChapterFromGardenID(garden.id, gardenCollection)
        .name;
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
