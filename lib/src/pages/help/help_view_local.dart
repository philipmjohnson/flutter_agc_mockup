import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../data_model/help_db.dart';

class HelpViewLocal extends StatelessWidget {
  const HelpViewLocal({
    super.key,
  });
  final String title = 'Local Help';
  static const routeName = '/help_local';

  @override
  Widget build(BuildContext context) {
    String routeName = ModalRoute.of(context)!.settings.arguments as String;
    String help = helpDB.getHelpString(routeName);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Help'),
        ),
        body: Markdown(data: help)
    );
  }
}
