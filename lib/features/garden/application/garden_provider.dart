import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/garden_db.dart';

final gardenDBProvider = Provider<GardenDB>((ref) {
  return GardenDB(ref);
});
