import 'package:flutter/material.dart';
import '../../components/drawer_view.dart';
import '../../components/help_button.dart';
import '../../data_model/chapter_db.dart';
import '../../data_model/user_db.dart';
import 'chapter_card_view.dart';

const pageSpecification = '''
# Chapters Page Specification

## Motivation/Goals

This page should help the user understand what Chapters are, and what Chapters they are a member of, and why.

Usually, the user is a member of only one Chapter.

## Contents 

Probably want to start with a dismissable documentation card at the top that explains the idea behind Chapters. 

Then a set of cards, one per Chapter, each containing:

* The Chapter name
* The number of members in the chapter.
* The zip code(s) associated with the chapter.
* A representative photo of the chapter. Maybe a map image delineating the chapter boundaries?
* Perhaps some information about the Crops being grown. 

## Actions 

Possible actions associated with each Chapter card:

* See the gardens associated with the Chapter.
* See the members associated with the Chapter.

''';

/// Displays Chapter information.
class ChaptersView extends StatelessWidget {
  const ChaptersView({
    super.key,
  });
  final String title = 'Chapters';
  static const routeName = '/chapters';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerView(),
      appBar: AppBar(
        title: const Text('Chapters'),
        actions: const [HelpButton(routeName: ChaptersView.routeName)],
      ),
      body: ListView(
          children: [
            ...chapterDB.getAssociatedChapterIDs(currentUserID).map((chapterID) => ChapterCardView(chapterID: chapterID))
          ]
      ),
      bottomNavigationBar: BottomNavigationBar(
        // type: BottomNavigationBarType.fixed, // needed when more than 3 items
        items: const [
          BottomNavigationBarItem(
            label: 'Filter',
            icon: Icon(Icons.filter_list),
          ),
          BottomNavigationBarItem(
            label: 'Sort',
            icon: Icon(Icons.sort),
          ),
        ],
      ),
    );
  }
}
