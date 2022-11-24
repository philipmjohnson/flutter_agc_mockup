import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'bodies/chapter_body_view.dart';
import 'bodies/home_body_view.dart';
import '../settings/settings_view.dart';
import '../sample_feature/sample_item.dart';
import '../sample_feature/sample_item_details_view.dart';
import 'bodies/notifications_body_view.dart';
import 'bodies/seeds_body_view.dart';

/// Top-level Layout. Interior page displayed based on NavBars.
class HomeLayoutView extends StatefulWidget {
  const HomeLayoutView(
      {super.key,
      this.items = const [SampleItem(1), SampleItem(2), SampleItem(3)],
      this.pages = const {
        0: {'title': Text('Home'), 'body': HomeBodyView()},
        1: {'title': Text('Chapter'), 'body': ChapterBodyView()},
        2: {'title': Text('Seeds'), 'body': SeedsBodyView()},
        3: {'title': Text('Notifications'), 'body': NotificationsBodyView()},
      }});

  static const routeName = '/home';
  final List<SampleItem> items;
  final Map pages;

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
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, // needed when more than 3 items
          items: [
            const BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
            ),
            const BottomNavigationBarItem(
              label: 'Chapter',
              icon: Icon(Icons.groups),
            ),
            const BottomNavigationBarItem(
              label: 'Seeds',
              icon: Icon(Icons.water_drop_outlined),
            ),
            BottomNavigationBarItem(
              label: 'Notifications',
              icon: Badge(
                  badgeContent: const Text('2', style: TextStyle(color: Colors.white)),
                  child: const Icon(Icons.notifications)),
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
        body: widget.pages[_selectedIndex]['body']
    );
  }
}
