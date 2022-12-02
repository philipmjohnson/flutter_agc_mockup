import 'package:flutter/material.dart';
import 'package:flutter_agc_mockup/src/data_model/user_db.dart';
import '../../../components/garden_summary_view.dart';
import '../../../data_model/garden_db.dart';

/// Displays a list of Gardens.
class GardensBodyView extends StatelessWidget {
  const GardensBodyView({
    super.key,
  });

  final String title = 'Gardens';

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
            children: gardenDB.getAssociatedGardenIDs(userID: currentUserID)
                .map((gardenID) => GardenSummaryView(gardenID: gardenID)).toList()
                .toList()));
  }
}
