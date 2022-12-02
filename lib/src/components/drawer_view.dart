import 'package:flutter/material.dart';
import 'package:flutter_agc_mockup/src/components/user_avatar.dart';
import 'package:flutter_agc_mockup/src/pages/outcomes/outcomes_view.dart';
import '../data_model/user_db.dart';
import '../pages/chapters/chapters_view.dart';
import '../pages/discussions/discussions_view.dart';
import '../pages/gardens/gardens_view.dart';
import '../pages/help/help_view.dart';
import '../pages/home/home_view.dart';
import '../pages/users/users_view.dart';
import '../pages/seeds/seeds_view.dart';
import '../pages/settings/settings_view.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserData user = userDB.getUser(currentUserID);
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user.name),
            accountEmail: Text(user.email),
            currentAccountPicture: UserAvatar(userID: user.id),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, HomeView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.yard_outlined),
            title: const Text('Gardens'),
            onTap: () {
              Navigator.pushReplacementNamed(context, GardensView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Members'),
            onTap: () {
              Navigator.pushReplacementNamed(context, UsersView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.groups),
            title: const Text('Chapters'),
            onTap: () {
              Navigator.pushReplacementNamed(context, ChaptersView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.trending_up),
            title: const Text('Outcomes'),
            onTap: () {
              Navigator.pushReplacementNamed(context, OutcomesView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.water_drop_outlined),
            title: const Text('Seeds'),
            onTap: () {
              Navigator.pushReplacementNamed(context, SeedsView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text('Discussions'),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, DiscussionsView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Help'),
            onTap: () {
              Navigator.pushReplacementNamed(context, HelpView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pushReplacementNamed(context, SettingsView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sign out'),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'bad page');
            },
          ),
        ],
      ),
    );
  }
}
