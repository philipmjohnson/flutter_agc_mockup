import 'package:flutter/material.dart';
import '../mockup_markdown/mockup_markdown.dart';

const pageSpecification = '''
# Discussions Page Specification

## Motivation/Goals

## Contents 

## Actions 

Possible actions associated with this card:

''';



/// Displays Chapter information.
class DiscussionsView extends StatelessWidget {
  const DiscussionsView({
    super.key,
  });
  final String title = 'Discussions';
  static const routeName = '/discussions';


  @override
  Widget build(BuildContext context) {
    return MockupMarkdownView(title: title, data: pageSpecification);
  }
}
