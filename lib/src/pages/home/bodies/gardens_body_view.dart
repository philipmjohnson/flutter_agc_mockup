import 'package:flutter/material.dart';
import 'package:flutter_agc_mockup/src/components/garden_summary_card.dart';
import '../../../entities/garden/garden_data.dart';

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
        child: ListView(children: [
          GardenSummaryCard(
              title: 'Alderwood Garden',
              subtitle: '19 beds, 162 plantings',
              imagePath: 'assets/images/garden-001.jpg'),
        ]));
  }
}
