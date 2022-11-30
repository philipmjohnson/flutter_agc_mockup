import 'package:flutter/material.dart';
import 'package:flutter_agc_mockup/src/components/user_avatar.dart';
import '../data/garden/garden_db.dart';
import '../data/user/user_db.dart';

class GardenSummaryUsersView extends StatelessWidget {
  GardenSummaryUsersView({Key? key, required String this.gardenID})
      : super(key: key);

  String gardenID;

  @override
  Widget build(BuildContext context) {
    GardenData gardenData = gardenDB.getGarden(gardenID);
    double padding = 10;

    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      UserAvatar(
          userID: gardenData.ownerID, label: 'Owner', rightPadding: padding),
      ...gardenData.editorIDs
          .map((editorID) => UserAvatar(
              userID: editorID, label: 'Editor', rightPadding: padding))
          .toList(),
      ...gardenData.viewerIDs
          .map((editorID) => UserAvatar(
              userID: editorID, label: 'Viewer', rightPadding: padding))
          .toList(),
    ]);
  }
}
