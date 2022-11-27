import 'package:flutter/material.dart';
import '../mockup_markdown/mockup_markdown.dart';



/// Displays Chapter information.
class ChapterView extends StatelessWidget {
  const ChapterView({
    super.key,
  });
  final String title = 'Chapter';
  static const routeName = '/chapter';

  final data = '''
# Chapter

This is the documentation for the chapter page. 
''';

  @override
  Widget build(BuildContext context) {
    return MockupMarkdownView(title: title, data: data);
  }
}
