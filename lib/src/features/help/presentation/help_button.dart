import 'package:flutter/material.dart';

import 'help_view_local.dart';

/// Provides the ? button at the top right and routes to the appropriate help documentation.
class HelpButton extends StatelessWidget {
  const HelpButton({Key? key, required this.routeName}) : super(key: key);

  final String routeName;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.help_outline),
      onPressed: () {
        Navigator.restorablePushNamed(context, HelpViewLocal.routeName, arguments: routeName);
      },
    );
  }
}
