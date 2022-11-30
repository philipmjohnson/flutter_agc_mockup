import 'package:flutter/material.dart';
import '../data/garden/garden_db.dart';
import '../data/user/user_db.dart';

class GardenSummaryUsersView extends StatelessWidget {
  GardenSummaryUsersView({Key? key, required String this.gardenID})
      : super(key: key);

  String gardenID;

  @override
  Widget build(BuildContext context) {
    GardenData gardenData = gardenDB.getGarden(gardenID);
    UserData ownerData = userDB.getUser(gardenData.ownerID);
    List<UserData> editorDatas = userDB.getUsers(gardenData.editorIDs);
    List<UserData> viewerDatas = userDB.getUsers(gardenData.viewerIDs);

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
