import 'package:flutter/material.dart';
import '../../../components/garden_summary_view.dart';
import '../../../data/garden/garden_data.dart';

/// Displays a list of Gardens.
class GardensBodyView extends StatelessWidget {
  GardensBodyView({
    super.key,
  });

  final String title = 'Gardens';
  List<GardenData> gardens = gardenDatas;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
            children: gardens
                .map((gardenData) => GardenSummaryView(
                    title: gardenData.name,
                    subtitle: gardenData.description,
                    imagePath: gardenData.imagePath,
                    ownerID: gardenData.ownerID,
                    editorIDs: gardenData.editorIDs,
                    viewerIDs: gardenData.viewerIDs))
                .toList()));
  }
}
