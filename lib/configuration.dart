import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

/// Provides global access to the contents of json files in assets/config/.
///
/// Load the key-value pairs in assets/config/config.json file with:
/// ```dart
/// await Configuration().load('config');
/// ```
/// You typically will do that in your main() function.
///
/// Access a key-value pair from a particular json file with:
/// ```dart
/// String admin = Configuration().get('config', 'admin_email');
/// ```
///
/// You can load any number of files.
///
/// Be sure to add the assets/config/ directory as an asset to your pubspec.yml.
/// Not currently used.
class Configuration {
  static final Configuration _singleton = Configuration._internal();

  factory Configuration() {
    return _singleton;
  }

  Configuration._internal();

  Map<String, dynamic> configMap = <String, dynamic>{};

  Future<Configuration> load(String name) async {
    String fileName = "$name.json";
    String content = await rootBundle.loadString("assets/config/$fileName");
    Map<String, dynamic> configAsMap = json.decode(content);
    configMap[name] = configAsMap;
    return _singleton;
  }

  dynamic get(String config, String key) => configMap[config][key];
}
