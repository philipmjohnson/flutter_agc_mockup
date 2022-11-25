import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
            ),
            child: Text(
              'Agile Garden Club',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Gardens'),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Seeds'),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Members'),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
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
