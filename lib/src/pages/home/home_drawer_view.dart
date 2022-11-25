import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

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
          ),
          ListTile(
            leading: Icon(Icons.yard_outlined),
            title: Text('Gardens'),
          ),
          ListTile(
            leading: Icon(Icons.groups),
            title: Text('Chapters'),
          ),
          ListTile(
            leading: Icon(Icons.trending_up),
            title: Text('Outcomes'),
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
        ],
      ),
    );
  }
}
