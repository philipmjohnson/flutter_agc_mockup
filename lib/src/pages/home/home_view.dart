import 'package:flutter/material.dart';
import 'package:flutter_agc_mockup/src/components/drawer_view.dart';
import 'package:flutter_agc_mockup/src/data_model/user_db.dart';
import '../../data_model/garden_db.dart';
import '../../data_model/news_db.dart';
import 'bodies/chapter_body_view.dart';
import 'bodies/gardens_body_view.dart';
import 'bodies/news_body_view.dart';
import '../settings/settings_view.dart';

/// Top-level Layout for all of the "Home" related
class HomeView extends StatefulWidget {
  HomeView({
    super.key,
  });

  static const routeName = '/home';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String numNews =
        newsDB.getAssociatedNewsIDs(currentUserID).length.toString();
    String numGardens =
        gardenDB.getAssociatedGardenIDs(currentUserID).length.toString();
    String numDiscussions = 0.toString();

    // This data structure will eventually become stateful and thus will
    // need to be moved into the state widget.
    final Map pages = {
      0: {
        'title': const Text('News'),
        'body': const NewsBodyView(),
        'navItem': BottomNavigationBarItem(
          label: 'My News ($numNews)',
          icon: Icon(Icons.newspaper),
        ),
      },
      1: {
        'title': const Text('Gardens'),
        'body': GardensBodyView(),
        'navItem': BottomNavigationBarItem(
          label: 'My Gardens ($numGardens)',
          icon: Icon(Icons.yard_outlined),
        ),
      },
      2: {
        'title': const Text('Chapter'),
        'body': const ChapterBodyView(),
        'navItem': BottomNavigationBarItem(
          label: 'My Discussions ($numDiscussions)',
          icon: Icon(Icons.chat),
        ),
      },
    };
    return Scaffold(
      drawer: const DrawerView(),
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: pages[_selectedIndex]['body'],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // needed when more than 3 items
        items: [
          pages[0]['navItem'],
          pages[1]['navItem'],
          pages[2]['navItem'],
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
