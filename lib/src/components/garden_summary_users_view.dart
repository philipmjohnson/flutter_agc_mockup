import 'package:flutter/material.dart';
import 'package:flutter_agc_mockup/src/components/user_access_view.dart';
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
        UserAccessView(userID: 'user-001', label: 'Owner'),
      ]),
      const SizedBox(width: 10),
      UserAccessView(userID: 'user-002', label: 'Editor'),
      const SizedBox(width: 10),
      UserAccessView(userID: 'user-003', label: 'Viewer'),
    ]);
  }
}
