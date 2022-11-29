/// Placeholder for garden data
class GardenData {
  GardenData(
      {required this.id,
      required this.name,
      required this.description,
      required this.ownerID,
      required this.imagePath,
      List<String>? editorIDs,
      List<String>? viewerIDs})
      : editorIDs = editorIDs ?? [],
        viewerIDs = viewerIDs ?? [];

  String id;
  String name;
  String description;
  String imagePath;
  String ownerID;
  List<String> editorIDs;
  List<String> viewerIDs;
}

List<GardenData> gardenDatas = [
  GardenData(
      id: 'garden-001',
      name: 'Alderwood Garden',
      description: '19 beds, 162 plantings',
      imagePath: 'assets/images/garden-001.jpg',
      ownerID: 'user-001',
      editorIDs: ['user-002'],
      viewerIDs: ['user-003']),

  GardenData(
      id: 'garden-002',
      name: 'SuperKale Garden',
      description: '17 beds, 149 plantings',
      imagePath: 'assets/images/garden-002.jpg',
      ownerID: 'user-002',
      viewerIDs: ['user-001'])
];
