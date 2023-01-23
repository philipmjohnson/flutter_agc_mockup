import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/garden.dart';
import 'garden_database.dart';

final gardenDatabaseProvider = Provider<GardenDatabase>((ref) {
  return GardenDatabase(ref);
});

final gardensStreamProvider = StreamProvider<List<Garden>>((ref) {
  final database = ref.watch(gardenDatabaseProvider);
  return database.watchGardens();
});

final gardensProvider = FutureProvider<List<Garden>>((ref) {
  final database = ref.watch(gardenDatabaseProvider);
  return database.fetchGardens();
});

// final gardenDBProvider = Provider<GardenDB>((ref) {
//   return GardenDB(ref);
// });
