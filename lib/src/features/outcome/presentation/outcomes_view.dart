import 'package:flutter/material.dart';
import '../../../common_widgets/mockup_markdown.dart';

const pageSpecification = '''
# Outcomes Page Specification

## Motivation/Goals

Outcomes are one of the most important value-added features of AGC, so we want to highlight them with their own page.

There are many ways to present outcomes:
  * At the variety and crop levels.
  * Aggregated over years, gardens, and (maybe) Chapters.

## Contents 

We will need to have a kind of "Explorer" for Outcome data, probably modeled on the React mockup.

## Actions 

You might want the ability to "drill-down" from an Outcome to the planting(s) that generated it.


''';



/// Displays Outcome information. (Not yet implemented)
class OutcomesView extends StatelessWidget {
  const OutcomesView({
    super.key,
  });
  final String title = 'Outcomes';
  static const routeName = '/outcomes';


  @override
  Widget build(BuildContext context) {
    return MockupMarkdownView(title: title, data: pageSpecification);
  }
}
