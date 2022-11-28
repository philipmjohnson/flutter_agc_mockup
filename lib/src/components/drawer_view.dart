import 'package:flutter/material.dart';
import 'package:flutter_agc_mockup/src/pages/outcomes/outcomes_view.dart';
import '../pages/chapters/chapters_view.dart';
import '../pages/discussions/discussions_view.dart';
import '../pages/gardens/gardens_view.dart';
import '../pages/help/help_view.dart';
import '../pages/home/home_view.dart';
import '../pages/members/members_view.dart';
import '../pages/seeds/seeds_view.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Jenna Deane"),
            accountEmail: Text("jennacorindeane@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/jenna-deane.jpg'),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, HomeView.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.yard_outlined),
            title: Text('Gardens'),
            onTap: () {
              Navigator.pushReplacementNamed(context, GardensView.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.groups),
            title: Text('Chapters'),
            onTap: () {
              Navigator.pushReplacementNamed(context, ChaptersView.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.trending_up),
            title: Text('Outcomes'),
            onTap: () {
              Navigator.pushReplacementNamed(context, OutcomesView.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.water_drop_outlined),
            title: Text('Seeds'),
            onTap: () {
              Navigator.pushReplacementNamed(context, SeedsView.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Members'),
            onTap: () {
              Navigator.pushReplacementNamed(context, MembersView.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.chat),
            title: Text('Discussions'),
            onTap: () {
              Navigator.pushReplacementNamed(context, DiscussionsView.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.help_outline),
            title: Text('Help'),
            onTap: () {
              Navigator.pushReplacementNamed(context, HelpView.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Sign out'),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'bad page');
            },
          ),
        ],
      ),
    );
  }
}
