import 'package:flutter/material.dart';
import '../../../common_widgets/mockup_markdown.dart';

const pageSpecification = '''
# Seeds Page Specification

## Motivation/Goals

This page provides the ability to manage your own saved seeds and to obtain saved seeds from other members of your Chapter.


## Contents 

Probably two top-level tabs: one for your own saved seeds and one for those available from other members of the Chapter. 

Could be a simple list, maybe a hierarchical list with crops at the top-level and varieties inside.

## Actions 

For your own seeds, manage how much you have left, whether or not you want to share them with the Chapter.

For Chapter seeds, contact the person who has them to request some.


''';



/// Displays Seed information. (Not yet implemented)
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
