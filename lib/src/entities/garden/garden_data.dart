/// Placeholder for garden data
class GardenData {

  GardenData({required this.id, required this.name, required this.description, required this.ownerID, required this.imagePath, List<String>? editorIDs, List<String>? viewerIDs}) : editorIDs = editorIDs ?? [], viewerIDs = viewerIDs ?? [];

  String id;
  String name;
  String description;
  String imagePath;
  String ownerID;
  List<String> editorIDs;
  List<String> viewerIDs;
}


List<GardenData> gardenDatas = [
  GardenData(id: 'alderwood', name: 'Alderwood Garden', description: '19 beds, 162 plantings', imagePath: 'assets/images/garden-001.jpg', ownerID: 'jd', editorIDs: ['jb'], viewerIDs: ['ja'])

];
