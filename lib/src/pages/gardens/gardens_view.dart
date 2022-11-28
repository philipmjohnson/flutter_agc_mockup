import 'package:flutter/material.dart';
import '../mockup_markdown/mockup_markdown.dart';

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



/// Displays Chapter information.
class GardensView extends StatelessWidget {
  const GardensView({
    super.key,
  });
  final String title = 'Gardens';
  static const routeName = '/gardens';


  @override
  Widget build(BuildContext context) {
    return MockupMarkdownView(title: title, data: pageSpecification);
  }
}
