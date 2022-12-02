import 'package:flutter/material.dart';

import '../pages/help/help_view_local.dart';

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
