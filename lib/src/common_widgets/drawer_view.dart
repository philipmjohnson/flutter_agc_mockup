import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/chapter/presentation/chapters_view.dart';
import '../features/discussion/presentation/discussions_view.dart';
import '../features/garden/presentation/gardens_view.dart';
import '../features/help/presentation/help_view.dart';
import '../features/outcome/presentation/outcomes_view.dart';
import '../features/seed/presentation/seeds_view.dart';
import '../features/settings/presentation/settings_view.dart';
import '../features/user/application/user_providers.dart';
import '../features/user/domain/user_db.dart';
import '../features/user/presentation/user_avatar.dart';
import '../features/user/presentation/users_view.dart';
import 'home_view.dart';

/// Provides the drop-down Drawer with the menu of top-level pages.
class DrawerView extends ConsumerWidget {
  const DrawerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserDB userDB = ref.watch(userDBProvider);
    final String currentUserID = ref.watch(currentUserIDProvider);
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
