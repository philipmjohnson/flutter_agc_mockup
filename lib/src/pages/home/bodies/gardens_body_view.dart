import 'package:flutter/material.dart';
import 'package:flutter_agc_mockup/src/components/garden_summary_card.dart';
import '../../sample_feature/sample_item.dart';
import '../../sample_feature/sample_item_details_view.dart';

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
        child: ListView(children: [
          GardenSummaryCard(),
        ]));
  }
}
