import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/app.dart';

/// Set up settings and wrap app in ProviderScope
void main() {
  runApp(ProviderScope(child: MyApp()));
}
