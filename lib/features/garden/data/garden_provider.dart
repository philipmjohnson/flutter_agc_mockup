import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/garden.dart';
import 'garden_database.dart';

final gardenDatabaseProvider = Provider<GardenDatabase>((ref) {
  return GardenDatabase(ref);
});

final gardensProvider = StreamProvider<List<Garden>>((ref) {
  final database = ref.watch(gardenDatabaseProvider);
  return database.watchGardens();
});
