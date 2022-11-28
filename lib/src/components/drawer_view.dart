import 'package:flutter/material.dart';
import 'package:flutter_agc_mockup/src/pages/outcomes/outcomes_view.dart';
import '../pages/chapters/chapters_view.dart';
import '../pages/gardens/gardens_view.dart';
import '../pages/home/home_view.dart';

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
              color: Theme.of(context).primaryColorDark,
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
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Members'),
          ),
          ListTile(
            leading: Icon(Icons.chat),
            title: Text('Discussions'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Sign out'),
          ),
        ],
      ),
    );
  }
}
