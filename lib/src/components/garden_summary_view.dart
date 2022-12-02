import 'package:flutter/material.dart';
import 'package:flutter_agc_mockup/src/components/garden_summary_users_view.dart';
import '../data_model/garden_db.dart';

class GardenSummaryView extends StatelessWidget {
  const GardenSummaryView({Key? key, required this.gardenID}) : super(key: key);

  final String gardenID;

  @override
  Widget build(BuildContext context) {
    GardenData gardenData = gardenDB.getGarden(gardenID);
    String title = gardenData.name;
    String subtitle = gardenData.description;
    String lastUpdate = gardenData.lastUpdate;
    String imagePath = gardenData.imagePath;
    String chapterName = gardenDB.getChapter(gardenID).name;
    AssetImage image = AssetImage(imagePath);
    return Card(
      elevation: 9,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            isThreeLine: true,
            title: Text('$title Garden'),
            subtitle: Text('$subtitle\n$chapterName Chapter'),
            trailing: const Icon(Icons.more_vert),
          ),
          SizedBox(
            height: 150.0,
            child: Ink.image(
              image: image,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          GardenSummaryUsersView(gardenID: gardenID),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.centerRight,
                child: Text('Last updated: $lastUpdate')),
          ),
        ],
      ),
    );
  }
}
