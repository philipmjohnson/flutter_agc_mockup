import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../repositories/firestore/firestore_path.dart';
import '../../../repositories/firestore/firestore_service.dart';
import 'garden.dart';

// Provides access to the Firestore database storing Garden documents.
class GardenDatabase {
  GardenDatabase(this.ref);

  final ProviderRef<GardenDatabase> ref;

  final _service = FirestoreService.instance;

  Stream<List<Garden>> watchGardens() => _service.watchCollection(
      path: FirestorePath.gardens(),
      builder: (data, documentId) => Garden.fromFirestore(data!, documentId));

  Stream<Garden> watchGarden(String GardenId) => _service.watchDocument(
      path: FirestorePath.garden(GardenId),
      builder: (data, documentId) => Garden.fromFirestore(data!, documentId));

  Future<List<Garden>> fetchGardens() => _service.fetchCollection(
      path: FirestorePath.gardens(),
      builder: (data, documentId) => Garden.fromFirestore(data!, documentId));

  Future<Garden> fetchGarden(String gardenId) => _service.fetchDocument(
      path: FirestorePath.garden(gardenId),
      builder: (data, documentId) => Garden.fromFirestore(data!, documentId));

  Future<void> setGarden(Garden garden) => _service.setData(
      path: FirestorePath.garden(garden.id), data: garden.toJson());
}
