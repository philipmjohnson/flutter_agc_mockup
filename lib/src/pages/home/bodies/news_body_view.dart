import 'package:flutter/material.dart';
import 'package:flutter_agc_mockup/src/pages/home/bodies/news_body_item_actions.dart';
import '../../sample_feature/sample_item.dart';
import '../../sample_feature/sample_item_details_view.dart';

/// Displays a list of Gardens.
class NewsBodyView extends StatelessWidget {
  const NewsBodyView({
    super.key,
    this.items = const [SampleItem(1), SampleItem(2), SampleItem(3)],
  });

  final List<SampleItem> items;
  final String title = 'Home';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: ListView(children: [
        ListTile(
          leading: Icon(Icons.severe_cold, color: Theme.of(context).primaryColor),
          title: Text('Frost Alert: 11/15/22'),
          subtitle: Text('Bellingham Chapter: Predicted overnight low of 37\u00B0 for 11/15/22'),
          trailing: NewsBodyItemActions(),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.image_search, color: Theme.of(context).primaryColor,),
          title: Text('Reply to: "Something is eating these bean sprouts..."'),
          subtitle: Text('Alderwood Garden: ... Looks like it could be a rabbit or...'),
          trailing: NewsBodyItemActions(),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.group_add, color: Theme.of(context).primaryColor),
          title: Text('New Chapter Members'),
          subtitle: Text('Bellingham Chapter: @AsaD, @CyTheGuy.'),
          trailing: NewsBodyItemActions(),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.water_drop, color: Theme.of(context).primaryColor),
          title: Text('New seed(s) available'),
          subtitle: Text("Bellingham Chapter: Lettuce (Flashy Trout's Back), Bean (Tanya's Pink Pod), Squash (Zepplin Delicata)"),
          trailing: NewsBodyItemActions(),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.yard_outlined, color: Theme.of(context).primaryColor),
          title: Text('First Harvest expected'),
          subtitle: Text('Alderwood Garden: Week of Nov 15: Pepper (Bridge to Paris), Pumpkin (Winter Luxury)'),
          trailing: NewsBodyItemActions(),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.pest_control, color: Theme.of(context).primaryColor),
          title: Text('Pest Alert: Aphids'),
          subtitle: Text('Bellingham Chapter: 10 gardens with Aphid pest observations this week'),
          trailing: NewsBodyItemActions(),
        ),
      ]),
    );
  }
}
