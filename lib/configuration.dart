import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

/// Provides access to the json files stored in the assets/config directory.
///
/// Load the key-value pairs in assets/config/config.json file with:
/// ```dart
/// await Configuration().load('config');
/// ```
/// You typically will do that in your main() function.
///
/// Access a key-value pair with:
/// ```dart
/// String admin = Configuration().get('admin_email');
/// ```
///
/// You can load any number of files. Make sure keys are unique across all files
/// to prevent overwriting!
///
/// Be sure to add the assets/config/ directory as an asset to your pubspec.yml.
class Configuration {
  static final Configuration _singleton = Configuration._internal();

  factory Configuration() {
    return _singleton;
  }

  Configuration._internal();

  Map<String, dynamic> configMap = <String, dynamic>{};

  Future<Configuration> load(String name) async {
    if (!name.endsWith(".json")) {
      name = "$name.json";
    }
    String content = await rootBundle.loadString("assets/config/$name");
    Map<String, dynamic> configAsMap = json.decode(content);
    configMap.addAll(configAsMap);
    return _singleton;
  }

  dynamic get(String key) => configMap[key];
}
