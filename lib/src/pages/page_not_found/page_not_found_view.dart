import 'package:flutter/material.dart';
import '../mockup_markdown/mockup_markdown.dart';

const pageSpecification = '''
# Page Not Found

This page appears when there is a bug in routing.
''';



/// Displays Chapter information.
class PageNotFoundView extends StatelessWidget {
  const PageNotFoundView({
    super.key,
  });
  final String title = 'Page Not Found';
  static const routeName = '/page_not_found';


  @override
  Widget build(BuildContext context) {
    return MockupMarkdownView(title: title, data: pageSpecification);
  }
}
