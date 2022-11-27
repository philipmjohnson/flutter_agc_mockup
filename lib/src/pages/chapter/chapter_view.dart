import 'package:flutter/material.dart';
import '../mockup_markdown/mockup_markdown.dart';



/// Displays Chapter information.
class ChapterView extends StatelessWidget {
  const ChapterView({
    super.key,
  });
  final String title = 'Chapters';
  static const routeName = '/chapter';

  final data = '''
# Chapters Page Specification

## Motivation/Goals

This page provides a set of cards for each Chapter that the user is a member of.

Usually, the user is a member of only one Chapter.

## Contents 

Each card should contain:

* The Chapter name
* The number of members in the chapter.
* The zip code(s) associated with the chapter.
* A representative photo of the chapter. Maybe a map image delineating the chapter boundaries?

## Actions 

Possible actions associated with this card:

* See the gardens associated with this Chapter.
* See the members associated with this Chapter.


''';

  @override
  Widget build(BuildContext context) {
    return MockupMarkdownView(title: title, data: data);
  }
}
