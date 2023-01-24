import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final scaffoldMessengerProvider =
    StateProvider<GlobalKey<ScaffoldMessengerState>>(
        (ref) => GlobalKey<ScaffoldMessengerState>());
