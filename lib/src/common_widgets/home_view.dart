import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/chapter/presentation/chapter_body_view.dart';
import '../features/garden/application/garden_provider.dart';
import '../features/garden/domain/garden_db.dart';
import '../features/garden/presentation/gardens_body_view.dart';
import '../features/help/presentation/help_button.dart';
import '../features/news/application/news_provider.dart';
import '../features/news/domain/news_db.dart';
import '../features/news/presentation/news_body_view.dart';
import '../features/user/application/user_providers.dart';
import 'drawer_view.dart';

/// Top-level Layout for all of the "Home" related subpages.
class HomeView extends ConsumerStatefulWidget {
  const HomeView({
    super.key,
  });

  static const routeName = '/home';

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
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
    final String currentUserID = ref.watch(currentUserIDProvider);
    final GardenDB gardenDB = ref.watch(gardenDBProvider);
    final NewsDB newsDB = ref.watch(newsDBProvider);
    String numNews =
        newsDB.getAssociatedNewsIDs(currentUserID).length.toString();
    String numGardens = gardenDB
        .getAssociatedGardenIDs(userID: currentUserID)
        .length
        .toString();
    String numDiscussions = 0.toString();

    // This data structure will eventually become stateful and thus will
    // need to be moved into the state widget.
    final Map pages = {
      0: {
        'title': const Text('News'),
        'body': const NewsBodyView(),
        'navItem': BottomNavigationBarItem(
          label: 'My News ($numNews)',
          icon: const Icon(Icons.newspaper),
        ),
      },
      1: {
        'title': const Text('Gardens'),
        'body': const GardensBodyView(),
        'navItem': BottomNavigationBarItem(
          label: 'My Gardens ($numGardens)',
          icon: const Icon(Icons.yard_outlined),
        ),
      },
      2: {
        'title': const Text('Chapter'),
        'body': const ChapterBodyView(),
        'navItem': BottomNavigationBarItem(
          label: 'My Discussions ($numDiscussions)',
          icon: const Icon(Icons.chat),
        ),
      },
    };
    return Scaffold(
      drawer: const DrawerView(),
      appBar: AppBar(
        title: const Text('Home'),
        actions: const [HelpButton(routeName: HomeView.routeName)],
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
