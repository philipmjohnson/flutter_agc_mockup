import 'package:flutter/material.dart';
import 'package:flutter_agc_mockup/features/async_value_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../chapter/domain/chapter.dart';
import '../../news/domain/news.dart';
import '../../user/data/user_providers.dart';
import '../../user/domain/user.dart';
import '../data/garden_provider.dart';
import '../domain/garden.dart';
import '../domain/garden_collection.dart';
import 'garden_summary_view.dart';

/// Builds a list of [GardenSummaryView].
class GardensBodyView extends ConsumerWidget {
  const GardensBodyView({
    super.key,
  });

  final String title = 'Gardens';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String currentUserID = ref.watch(currentUserIDProvider);
    final AsyncValue<List<Garden>> asyncGardens = ref.watch(gardensProvider);
    return MultiAsyncValuesWidget(
        context: context,
        currentUserID: currentUserID,
        asyncGardens: asyncGardens,
        data: _build);
  }

  Widget _build(
      {required BuildContext context,
      required String currentUserID,
      List<Chapter>? chapters,
      List<Garden>? gardens,
      List<News>? news,
      List<User>? users}) {
    GardenCollection gardenCollection = GardenCollection(gardens);
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
            children: gardenCollection
                .getAssociatedGardens(userID: currentUserID)
                .map((garden) => GardenSummaryView(garden: garden))
                .toList()));
  }
}
