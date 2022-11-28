import 'package:flutter/material.dart';
import '../mockup_markdown/mockup_markdown.dart';

const pageSpecification = '''
# Seeds Page Specification

## Motivation/Goals


## Contents 


## Actions 


## Issues


''';



/// Displays Chapter information.
class SeedsView extends StatelessWidget {
  const SeedsView({
    super.key,
  });
  final String title = 'Seeds';
  static const routeName = '/seeds';


  @override
  Widget build(BuildContext context) {
    return MockupMarkdownView(title: title, data: pageSpecification);
  }
}
