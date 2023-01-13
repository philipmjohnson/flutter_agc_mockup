import 'package:freezed_annotation/freezed_annotation.dart';

part 'garden.freezed.dart';
part 'garden.g.dart';

@freezed
class Garden with _$Garden {
  const factory Garden({
    required String id,
    required String name,
    required String description,
    required String imagePath,
    required String ownerID,
    required String chapterID,
    required String lastUpdate,
    @Default([]) List<String> editorIDs,
    @Default([]) List<String> viewerIDs,
  }) = _Garden;

  factory Garden.fromJson(Map<String, dynamic> json) => _$GardenFromJson(json);
}
