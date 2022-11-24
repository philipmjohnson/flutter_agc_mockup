import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'bodies/chapter_body_view.dart';
import 'bodies/home_body_view.dart';
import '../settings/settings_view.dart';
import 'bodies/notifications_body_view.dart';
import 'bodies/seeds_body_view.dart';

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
      'title': const Text('Home'),
      'body': const HomeBodyView(),
      'navItem': const BottomNavigationBarItem(
        label: 'Home',
        icon: Icon(Icons.home),
      ),
    },
    1: {
      'title': const Text('Chapter'),
      'body': const ChapterBodyView(),
      'navItem': const BottomNavigationBarItem(
        label: 'Chapter',
        icon: Icon(Icons.groups),
      ),
    },
    2: {
      'title': const Text('Seeds'),
      'body': const SeedsBodyView(),
      'navItem': const BottomNavigationBarItem(
        label: 'Seeds',
        icon: Icon(Icons.water_drop_outlined),
      ),
    },
    3: {
      'title': const Text('Notifications'),
      'body': const NotificationsBodyView(),
      'navItem': BottomNavigationBarItem(
        label: 'Notifications',
        icon: Badge(
            badgeContent:
                const Text('2', style: TextStyle(color: Colors.white)),
            child: const Icon(Icons.notifications)),
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
      appBar: AppBar(
        title: widget.pages[_selectedIndex]['title'],
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
