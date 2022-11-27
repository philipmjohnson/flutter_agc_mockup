import 'package:flutter/material.dart';

class GardenSummaryCard extends StatelessWidget {
  const GardenSummaryCard({Key? key}) : super(key: key);

  final title = "Alderwood Garden";
  final subtitle = "19 beds, 162 plantings";
  final image = const AssetImage('assets/images/garden-001.jpg');

  @override
  Widget build(BuildContext context) {
    return Card(
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
