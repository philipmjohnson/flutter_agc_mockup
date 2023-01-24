import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../async_value_widget.dart';
import '../../chapter/domain/chapter.dart';
import '../../news/domain/news.dart';
import '../../user/data/user_providers.dart';
import '../../user/domain/user.dart';
import '../../user/presentation/user_labeled_avatar.dart';
import '../data/garden_provider.dart';
import '../domain/garden.dart';
import '../domain/garden_collection.dart';

/// Builds a row of User avatars associated with a gardenID.
class GardenSummaryUsersView extends ConsumerWidget {
  const GardenSummaryUsersView({Key? key, required this.gardenID})
      : super(key: key);

  final String gardenID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Garden>> asyncGardens = ref.watch(gardensProvider);
    final String currentUserID = ref.watch(currentUserIDProvider);
    return MultiAsyncValuesWidget(
        context: context,
        currentUserID: currentUserID,
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
    double padding = 10;
    Garden garden = GardenCollection(gardens).getGarden(gardenID);
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      UserLabeledAvatar(
          userID: garden.ownerID, label: 'Owner', rightPadding: padding),
      ...garden.editorIDs
          .map((editorID) => UserLabeledAvatar(
              userID: editorID, label: 'Editor', rightPadding: padding))
          .toList(),
      ...garden.viewerIDs
          .map((editorID) => UserLabeledAvatar(
              userID: editorID, label: 'Viewer', rightPadding: padding))
          .toList(),
    ]);
  }
}
