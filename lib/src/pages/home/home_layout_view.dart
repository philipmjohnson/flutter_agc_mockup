import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'bodies/chapter_body_view.dart';
import 'bodies/gardens_body_view.dart';
import 'bodies/news_body_view.dart';
import '../settings/settings_view.dart';
import 'bodies/seeds_body_view.dart';
import 'home_drawer_view.dart';

/// Top-level Layout for all of the "Home" related
class HomeLayoutView extends StatefulWidget {
  HomeLayoutView({
    super.key,
  });

  static const routeName = '/home';

  // This data structure will eventually become stateful and thus will
  // need to be moved into the state widget.
  final Map pages = {
    0: {
      'title': const Text('News'),
      'body': const NewsBodyView(),
      'navItem': const BottomNavigationBarItem(
        label: 'My News',
        icon: Icon(Icons.newspaper),
      ),
    },
    1: {
      'title': const Text('Gardens'),
      'body': const GardensBodyView(),
      'navItem': const BottomNavigationBarItem(
        label: 'My Gardens',
        icon: Icon(Icons.yard_outlined),
      ),
    },
    2: {
      'title': const Text('Chapter'),
      'body': const ChapterBodyView(),
      'navItem': const BottomNavigationBarItem(
        label: 'My Discussions',
        icon: Icon(Icons.chat),
      ),
    },
    3: {
      'title': const Text('Seeds'),
      'body': const SeedsBodyView(),
      'navItem': const BottomNavigationBarItem(
        label: 'My Seeds',
        icon: Icon(Icons.water_drop_outlined),
      ),
    },
  };

  @override
  State<HomeLayoutView> createState() => _HomeLayoutViewState();
}

class _HomeLayoutViewState extends State<HomeLayoutView> {
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
    return Scaffold(
      drawer: const HomeDrawer(),
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('Home'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: widget.pages[_selectedIndex]['body'],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // needed when more than 3 items
        items: [
          widget.pages[0]['navItem'],
          widget.pages[1]['navItem'],
          widget.pages[2]['navItem'],
          widget.pages[3]['navItem'],
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
