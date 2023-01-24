import 'package:firebase_ui_auth/firebase_ui_auth.dart' hide UserAvatar;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'async_value_widget.dart';
import 'authentication/presentation/signin_view.dart';
import 'chapter/presentation/chapters_view.dart';
import 'discussion/presentation/discussions_view.dart';
import 'garden/presentation/gardens_view.dart';
import 'help/presentation/help_view.dart';
import 'home_view.dart';
import 'outcome/presentation/outcomes_view.dart';
import 'seed/presentation/seeds_view.dart';
import 'settings/presentation/settings_view.dart';
import 'user/data/user_providers.dart';
import 'user/domain/user.dart';
import 'user/presentation/user_avatar.dart';
import 'user/presentation/users_view.dart';

/// Builds the drop-down Drawer with the menu of top-level pages.
class DrawerView extends ConsumerWidget {
  const DrawerView({Key? key}) : super(key: key);

  @override
  build(BuildContext context, WidgetRef ref) {
    AsyncValue<User> asyncUser = ref.watch(currentUserProvider);
    return AsyncValueWidget<User>(
        value: asyncUser,
        data: (user) => Drawer(
              child: ListView(
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(user.name),
                    accountEmail: Text(user.id),
                    currentAccountPicture: UserAvatar(userID: user.id),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, HomeView.routeName);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.yard_outlined),
                    title: const Text('Gardens'),
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, GardensView.routeName);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Members'),
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, UsersView.routeName);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.groups),
                    title: const Text('Chapters'),
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, ChaptersView.routeName);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.trending_up),
                    title: const Text('Outcomes'),
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, OutcomesView.routeName);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.water_drop_outlined),
                    title: const Text('Seeds'),
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, SeedsView.routeName);
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
                      Navigator.pushReplacementNamed(
                          context, HelpView.routeName);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, SettingsView.routeName);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Sign out'),
                    onTap: () {
                      FirebaseUIAuth.signOut(context: context);
                      Navigator.pushReplacementNamed(
                          context, SignInView.routeName);
                    },
                  ),
                ],
              ),
            ));
  }
}
