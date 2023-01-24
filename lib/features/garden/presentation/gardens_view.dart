import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../async_value_widget.dart';
import '../../chapter/domain/chapter.dart';
import '../../drawer_view.dart';
import '../../help/presentation/help_button.dart';
import '../../news/domain/news.dart';
import '../../user/data/user_providers.dart';
import '../../user/domain/user.dart';
import '../data/garden_provider.dart';
import '../domain/garden.dart';
import '../domain/garden_collection.dart';
import 'add_garden_view.dart';
import 'garden_summary_view.dart';

const pageSpecification = '''
# Gardens Page Specification

## Motivation/Goals

This page has two top-level tabs:

* The first provides access to both the user's own gardens (i.e. the ones they are the owner of, or an editor of, or a viewer or). This is equivalent to the "My Gardens" tab in the Home page.

* The second provides access to all of the gardens in all of the Chapters. This could get large.

## Contents 

Probably want to start with a dismissable documentation card at the top that explains the idea behind Gardens, and/or how to navigate. 

Then a set of cards, one per Garden, each containing a summary of the garden.

Clicking on a card takes you to a more detailed view of the garden? 

## Actions 

Possible actions associated with each card:

* Edit the garden associated with the Card.

## Issues

* Should there be an expandable card to provide more details about a garden for those gardens that are not yours?

''';

/// Builds a page presenting all of the defined [Garden].
class GardensView extends ConsumerWidget {
  const GardensView({
    super.key,
  });

  static const routeName = '/gardens';

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
    return Scaffold(
      drawer: const DrawerView(),
      appBar: AppBar(
        title: Text('Gardens (${gardenCollection.size()})'),
        actions: const [HelpButton(routeName: GardensView.routeName)],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.restorablePushNamed(context, AddGardenView.routeName);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
              children: gardenCollection
                  .getAssociatedGardens(userID: currentUserID)
                  .map((garden) => GardenSummaryView(garden: garden))
                  .toList())),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          children: const <Widget>[],
        ),
      ),
    );
  }
}
