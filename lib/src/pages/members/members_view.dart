import 'package:flutter/material.dart';
import '../mockup_markdown/mockup_markdown.dart';

const pageSpecification = '''
# Members Page Specification

## Motivation/Goals

## Contents 

## Actions 

Possible actions associated with this card:

''';



/// Displays Chapter information.
class MembersView extends StatelessWidget {
  const MembersView({
    super.key,
  });
  final String title = 'Members';
  static const routeName = '/members';


  @override
  Widget build(BuildContext context) {
    return MockupMarkdownView(title: title, data: pageSpecification);
  }
}
