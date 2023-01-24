import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../async_value_widget.dart';
import '../../chapter/data/chapter_provider.dart';
import '../../chapter/domain/chapter.dart';
import '../../chapter/domain/chapter_collection.dart';
import '../../drawer_view.dart';
import '../../garden/data/garden_provider.dart';
import '../../garden/domain/garden.dart';
import '../../garden/domain/garden_collection.dart';
import '../../help/presentation/help_button.dart';
import '../../news/domain/news.dart';
import '../data/user_providers.dart';
import '../domain/user.dart';
import '../domain/user_collection.dart';
import 'user_card_view.dart';

const pageSpecification = '''
# Users Page Specification

## Motivation/Goals

We want this page to facilitate the creation of a local "Community of Practice".

On the other hand, we want to preserve privacy. 

So, we will need to ability for members to manage how much of their information is made available to others. 

## Contents

Since people can be part of more than one Chapter, we might have to have a top-level card or maybe an expandable card? 

It should list the "public profile" for a member, which could include their username, the gardens they own, maybe something about their crops.  

## Actions 

It should be possible to message members.  This seems crucial to create a community of practice.

If folks can be messaged, then it should also be possible for a member to block messages from another person. 

Maybe you can request "messaging privilege" or something from another member, so by default you can't message others? 

''';

/// Builds a page containing [UserCardView] information.
class UsersView extends ConsumerWidget {
  const UsersView({
    super.key,
  });

  static const routeName = '/users';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String currentUserID = ref.watch(currentUserIDProvider);
    final AsyncValue<List<Chapter>> asyncChapters = ref.watch(chaptersProvider);
    final AsyncValue<List<Garden>> asyncGardens = ref.watch(gardensProvider);
    final AsyncValue<List<User>> asyncUsers = ref.watch(usersProvider);
    return MultiAsyncValuesWidget(
        context: context,
        currentUserID: currentUserID,
        asyncChapters: asyncChapters,
        asyncGardens: asyncGardens,
        asyncUsers: asyncUsers,
        data: _build);
  }

  Widget _build(
      {required BuildContext context,
      required String currentUserID,
      List<Chapter>? chapters,
      List<Garden>? gardens,
      List<News>? news,
      List<User>? users}) {
    ChapterCollection chapterCollection = ChapterCollection(chapters);
    GardenCollection gardenCollection = GardenCollection(gardens);
    UserCollection userCollection = UserCollection(users);
    return Scaffold(
      drawer: const DrawerView(),
      appBar: AppBar(
        title: Text('Members (${userCollection.size()})'),
        actions: const [HelpButton(routeName: UsersView.routeName)],
      ),
      body: ListView(children: [
        ...chapterCollection
            .getAssociatedUsersOfUserID(
                currentUserID, gardenCollection, userCollection)
            .map((user) => UserCardView(user: user))
      ]),
      bottomNavigationBar: BottomNavigationBar(
        // type: BottomNavigationBarType.fixed needed when more than 3 items
        items: const [
          BottomNavigationBarItem(
            label: 'Filter',
            icon: Icon(Icons.filter_list),
          ),
          BottomNavigationBarItem(
            label: 'Sort',
            icon: Icon(Icons.sort),
          ),
        ],
      ),
    );
  }
}
