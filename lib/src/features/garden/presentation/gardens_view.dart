import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widgets/drawer_view.dart';
import '../../help/presentation/help_button.dart';
import '../../user/application/user_providers.dart';
import '../application/garden_provider.dart';
import '../domain/garden_db.dart';
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

/// Provides a page presenting all of the defined Gardens.
class GardensView extends ConsumerWidget {
  const GardensView({
    super.key,
  });

  final String title = 'Gardens';
  static const routeName = '/gardens';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GardenDB gardenDB = ref.watch(gardenDBProvider);
    final String currentUserID = ref.watch(currentUserIDProvider);
    return Scaffold(
      drawer: const DrawerView(),
      appBar: AppBar(
        title: const Text('Gardens'),
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
              children: gardenDB
                  .getAssociatedGardenIDs(userID: currentUserID)
                  .map((gardenID) => GardenSummaryView(gardenID: gardenID))
                  .toList()
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
