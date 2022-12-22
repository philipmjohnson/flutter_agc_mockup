import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/common_widgets/app.dart';

/// Set up settings and wrap app in ProviderScope
void main() {
  runApp(const ProviderScope(child: MyApp()));
}
