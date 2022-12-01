import 'package:flutter/material.dart';
import 'package:flutter_agc_mockup/src/components/garden_summary_users_view.dart';
import '../data_model/garden_db.dart';

class GardenSummaryView extends StatelessWidget {
  GardenSummaryView({Key? key, required this.gardenID}) : super(key: key);

  String gardenID;

  @override
  Widget build(BuildContext context) {
    GardenData gardenData = gardenDB.getGarden(gardenID);
    String title = gardenData.name;
    String subtitle = gardenData.description;
    String imagePath = gardenData.imagePath;
    AssetImage image = AssetImage(imagePath);
    return Card(
      elevation: 9,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          debugPrint('Card tapped.');
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(title),
              subtitle: Text(subtitle),
            ),
            Container(
              height: 100.0,
              child: Ink.image(
                image: image,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            GardenSummaryUsersView(gardenID: gardenID),
            const SizedBox(width: 8),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
              TextButton(
                child: const Text('Edit'),
                onPressed: () {
                  /* ... */
                },
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
