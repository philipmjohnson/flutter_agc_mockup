import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'async_value_widget.dart';
import 'chapter/domain/chapter.dart';
import 'discussion/presentation/discussions_body_view.dart';
import 'drawer_view.dart';
import 'garden/data/garden_provider.dart';
import 'garden/domain/garden.dart';
import 'garden/domain/garden_collection.dart';
import 'garden/presentation/gardens_body_view.dart';
import 'help/presentation/help_button.dart';
import 'news/data/news_provider.dart';
import 'news/domain/news.dart';
import 'news/domain/news_collection.dart';
import 'news/presentation/news_body_view.dart';
import 'user/data/user_providers.dart';
import 'user/domain/user.dart';

/// Build the home page.
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
    final AsyncValue<List<Garden>> asyncGardens = ref.watch(gardensProvider);
    final AsyncValue<List<News>> asyncNews = ref.watch(newsProvider);
    final String currentUserID = ref.watch(currentUserIDProvider);
    return MultiAsyncValuesWidget(
        context: context,
        currentUserID: currentUserID,
        asyncGardens: asyncGardens,
        asyncNews: asyncNews,
        data: _build);
  }

  Widget _build(
      {required BuildContext context,
      required String currentUserID,
      List<Chapter>? chapters,
      List<Garden>? gardens,
      List<News>? news,
      List<User>? users}) {
    final gardenCollection = GardenCollection(gardens);
    final newsCollection = NewsCollection(news);
    String numNews =
        newsCollection.getAssociatedNewsIDs(currentUserID).length.toString();
    String numGardens = gardenCollection
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
        'title': const Text('Discussions'),
        'body': const DiscussionsBodyView(),
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
