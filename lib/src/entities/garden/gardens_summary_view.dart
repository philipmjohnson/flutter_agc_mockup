import 'package:flutter/material.dart';

class GardenSummaryView extends StatelessWidget {
  GardenSummaryView({Key? key, required this.title, required this.subtitle, required this.imagePath}) : super(key: key);

  String title;
  String subtitle;
  String imagePath;

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
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Column(children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/jenna-deane.jpg'),
                ),
                Text("Owner"),
              ]),
              const SizedBox(width: 10),
              Column(children: [
                CircleAvatar(
                  child: const Text("JB"),
                ),
                Text("Editor"),
              ]),
              const SizedBox(width: 10),
              Column(children: [
                CircleAvatar(
                  child: const Text("JA"),
                ),
                Text("Viewer"),
              ]),
            ]),
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
