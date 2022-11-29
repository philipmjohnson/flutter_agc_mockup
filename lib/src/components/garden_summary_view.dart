import 'package:flutter/material.dart';
import 'package:flutter_agc_mockup/src/components/garden_summary_users_view.dart';

class GardenSummaryView extends StatelessWidget {
  GardenSummaryView({Key? key, required this.title, required this.subtitle, required this.imagePath, required this.ownerID, required this.editorIDs, required this.viewerIDs}) : super(key: key);

  String title;
  String subtitle;
  String imagePath;
  String ownerID;
  List<String> editorIDs;
  List<String> viewerIDs;

  @override
  Widget build(BuildContext context) {
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
              height: 200.0,
              child: Ink.image(
                image: image,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            GardenSummaryUsersView(gardenID: 'garden-001'),
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
