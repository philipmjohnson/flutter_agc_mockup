import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/help_provider.dart';
import '../domain/help_db.dart';

/// Displays the context-sensitive Help (i.e. the ? icon in the upper right corner).
class HelpViewLocal extends ConsumerWidget {
  const HelpViewLocal({
    super.key,
  });

  final String title = 'Local Help';
  static const routeName = '/help_local';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HelpDB helpDB = ref.watch(helpDBProvider);
    String routeName = ModalRoute.of(context)!.settings.arguments as String;
    String help = helpDB.getHelpString(routeName);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Help'),
        ),
        body: Markdown(data: help));
  }
}
