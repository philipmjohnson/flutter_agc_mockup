import 'package:flutter/material.dart';
import '../../../components/garden_summary_view.dart';
import '../../../data/garden/garden_db.dart';

/// Displays a list of Gardens.
class GardensBodyView extends StatelessWidget {
  GardensBodyView({
    super.key,
  });

  final String title = 'Gardens';

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
            children: gardenDB.getGardenIDs()
                .map((gardenID) => GardenSummaryView(gardenID: gardenID)).toList()
                .toList()));
  }
}
