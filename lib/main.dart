import 'package:flutter/material.dart';
import 'src/app.dart';
import 'src/pages/settings/settings_controller.dart';
import 'src/pages/settings/settings_service.dart';
import 'package:json_theme/json_theme.dart';
import 'package:flutter/services.dart'; // For rootBundle
import 'dart:convert'; // For jsonDecode

void main() async {
  // Find and load the Appainter-generated theme
  WidgetsFlutterBinding.ensureInitialized();
  final themeStr = await rootBundle.loadString('assets/theme/appainter_theme_green1.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;
  // Set up the SettingsController
  final settingsController = SettingsController(SettingsService());
  // Load the user's preferred theme (light or dark) while the splash screen is displayed.
  await settingsController.loadSettings();
  // Run the app and pass in the SettingsController.
  runApp(MyApp(settingsController: settingsController, theme: theme));
}
