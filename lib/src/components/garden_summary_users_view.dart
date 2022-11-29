import 'package:flutter/material.dart';

import '../data/garden/garden_data.dart';
import '../data/user/user_data.dart';

class GardenSummaryUsersView extends StatelessWidget {
  GardenSummaryUsersView({Key? key, required String this.gardenID})
      : super(key: key);

  String gardenID;
  List<GardenData> gardens = gardenDatas;
  List<UserData> users = userDatas;

  @override
  Widget build(BuildContext context) {
    GardenData gardenData =
        gardens.firstWhere((gardenData) => gardenData.id == this.gardenID);
    print(gardenData);
    print(gardenData.ownerID);
    UserData ownerData =
        users.firstWhere((UserData) => UserData.id == gardenData.ownerID);
    List<UserData> editorDatas = users
        .where((UserData) => gardenData.editorIDs.contains(UserData.id))
        .toList();
    List<UserData> viewerDatas = users
        .where((UserData) => gardenData.viewerIDs.contains(UserData.id))
        .toList();

    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Column(children: [
        CircleAvatar(
          backgroundImage: AssetImage('assets/images/jenna-deane.jpg'),
        ),
        Text("Owner2"),
      ]),
      const SizedBox(width: 10),
      Column(children: [
        CircleAvatar(
          child: const Text("JB"),
        ),
        Text("Editor"),
      ]),
      const SizedBox(width: 10),
      Column(children: [
        CircleAvatar(
          child: const Text("JA"),
        ),
        Text("Viewer"),
      ]),
    ]);
  }
}
