import 'package:flutter/material.dart';
import 'package:flutter_agc_mockup/src/pages/users/user_card_view.dart';
import '../../components/drawer_view.dart';
import '../../components/help_button.dart';
import '../../data_model/user_db.dart';

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

/// Displays User information.
class UsersView extends StatelessWidget {
  const UsersView({
    super.key,
  });
  final String title = 'Users';
  static const routeName = '/users';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerView(),
      appBar: AppBar(
        title: const Text('Members'),
        actions: const [HelpButton(routeName: UsersView.routeName)],
      ),
      body: ListView(
          children: [
            ...userDB.getAssociatedUserIDs(currentUserID).map((userID) => UserCardView(userID: userID))
        ]
      ),
      bottomNavigationBar: BottomNavigationBar(
        // type: BottomNavigationBarType.fixed, // needed when more than 3 items
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
