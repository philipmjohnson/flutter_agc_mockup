import 'package:flutter/material.dart';
import 'package:flutter_agc_mockup/src/data_model/user_db.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../components/garden_summary_view.dart';
import '../../../data_model/garden_db.dart';

/// Displays a list of Gardens.
class GardensBodyView extends ConsumerWidget {
  const GardensBodyView({
    super.key,
  });

  final String title = 'Gardens';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GardenDB gardenDB = ref.watch(gardenDBProvider);
    final String currentUserID = ref.watch(currentUserIDProvider);
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
            children: gardenDB.getAssociatedGardenIDs(userID: currentUserID)
                .map((gardenID) => GardenSummaryView(gardenID: gardenID)).toList()
                .toList()));
  }
}
