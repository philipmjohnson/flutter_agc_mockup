import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../user/presentation/user_labeled_avatar.dart';
import '../application/garden_provider.dart';
import '../domain/garden_db.dart';

/// Provides a row of User avatars associated with a gardenID.
class GardenSummaryUsersView extends ConsumerWidget {
  const GardenSummaryUsersView({Key? key, required this.gardenID})
      : super(key: key);

  final String gardenID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GardenDB gardenDB = ref.watch(gardenDBProvider);
    GardenData gardenData = gardenDB.getGarden(gardenID);
    double padding = 10;

    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      UserLabeledAvatar(
          userID: gardenData.ownerID, label: 'Owner', rightPadding: padding),
      ...gardenData.editorIDs
          .map((editorID) => UserLabeledAvatar(
              userID: editorID, label: 'Editor', rightPadding: padding))
          .toList(),
      ...gardenData.viewerIDs
          .map((editorID) => UserLabeledAvatar(
              userID: editorID, label: 'Viewer', rightPadding: padding))
          .toList(),
    ]);
  }
}
