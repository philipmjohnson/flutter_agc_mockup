import 'package:flutter/material.dart';
import 'package:flutter_agc_mockup/src/components/drawer_view.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MockupMarkdownView extends StatelessWidget {
  const MockupMarkdownView({Key? key, this.title = "Title", this.data = "Data"}) : super(key: key);

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerView(),
      appBar: AppBar(
        title: Text(title),
      ),
      body: Markdown(data: data)
    );
  }
}
