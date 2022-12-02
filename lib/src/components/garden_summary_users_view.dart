import 'package:flutter/material.dart';
import 'package:flutter_agc_mockup/src/components/user_labeled_avatar.dart';
import '../data_model/garden_db.dart';

class GardenSummaryUsersView extends StatelessWidget {
  const GardenSummaryUsersView({Key? key, required this.gardenID})
      : super(key: key);

  final String gardenID;

  @override
  Widget build(BuildContext context) {
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
