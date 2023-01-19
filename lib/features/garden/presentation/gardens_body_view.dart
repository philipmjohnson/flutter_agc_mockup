import 'package:flutter/material.dart';
import 'package:flutter_agc_mockup/async_value_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../user/application/user_providers.dart';
import '../application/garden_provider.dart';
import '../domain/garden.dart';
import 'garden_summary_view.dart';

/// Displays a list of Gardens.
class GardensBodyView extends ConsumerWidget {
  const GardensBodyView({
    super.key,
  });

  final String title = 'Gardens';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Garden>> asyncGardens = ref.watch(gardensProvider);
    final String currentUserID = ref.watch(currentUserIDProvider);
    return AsyncValuesAGCWidget(
        asyncGardens: asyncGardens,
        data: ({gardens}) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
                children: gardens!
                    .map((garden) => GardenSummaryView(garden: garden))
                    .toList())));
    // return Padding(
    //     padding: const EdgeInsets.all(10.0),
    //     child: ListView(
    //         children: gardenDB
    //             .getAssociatedGardenIDs(userID: currentUserID)
    //             .map((gardenID) => GardenSummaryView(gardenID: gardenID))
    //             .toList()
    //             .toList()));
  }
}
