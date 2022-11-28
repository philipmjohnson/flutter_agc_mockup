import 'package:flutter/material.dart';
import '../mockup_markdown/mockup_markdown.dart';

const pageSpecification = '''
# Outcomes Page Specification

## Motivation/Goals

It seems to me that Outcomes should have a top-level page. 

There are outcomes both at the individual garden level, and aggregate outcomes for an entire chapter. 

## Contents 

Not sure how to organize outcomes beyond the mockup.

## Actions 

I don't think there are any actions

## Issues

* Should there be an expandable card to provide more details about a garden for those gardens that are not yours?

''';



/// Displays Chapter information.
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
