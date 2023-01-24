import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../repositories/firestore/firestore_path.dart';
import '../../../repositories/firestore/firestore_service.dart';
import '../../global_snackbar.dart';
import '../domain/garden.dart';

/// Provides access to the Firestore database storing [Garden] documents.
class GardenDatabase {
  GardenDatabase(this.ref);

  final ProviderRef<GardenDatabase> ref;

  final _service = FirestoreService.instance;

  Stream<List<Garden>> watchGardens() => _service.watchCollection(
      path: FirestorePath.gardens(),
      builder: (data, documentId) => Garden.fromJson(data!));

  Stream<Garden> watchGarden(String gardenId) => _service.watchDocument(
      path: FirestorePath.garden(gardenId),
      builder: (data, documentId) => Garden.fromJson(data!));

  Future<List<Garden>> fetchGardens() => _service.fetchCollection(
      path: FirestorePath.gardens(),
      builder: (data, documentId) => Garden.fromJson(data!));

  Future<Garden> fetchGarden(String gardenId) => _service.fetchDocument(
      path: FirestorePath.garden(gardenId),
      builder: (data, documentId) => Garden.fromJson(data!));

  Future<void> setGarden(Garden garden) => _service
      .setData(path: FirestorePath.garden(garden.id), data: garden.toJson())
      .then((val) => GlobalSnackBar.show('Garden update succeeded.'))
      .catchError(
          (e) => GlobalSnackBar.show('Garden update failed\n${e.toString()}.'));
}
