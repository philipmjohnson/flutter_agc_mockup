import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        {
          Navigator.pushNamed(context, '/home');
        }
        break;
      case 1:
        {
          Navigator.pushNamed(context, '/list_gardens');
        }
        break;
      default:
        {
          Navigator.pushNamed(context, '/home');
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed, // needed when more than 3 items
      items: [
        const BottomNavigationBarItem(
          label: 'Home',
          icon: Icon(Icons.home),
        ),
        const BottomNavigationBarItem(
          label: 'Chapter',
          icon: Icon(Icons.groups),
        ),
        const BottomNavigationBarItem(
          label: 'Seeds',
          icon: Icon(Icons.water_drop_outlined),
        ),
        BottomNavigationBarItem(
          label: 'Notifications',
          icon: Badge(
              child: Icon(Icons.notifications),
              badgeContent: Text('2', style: TextStyle(color: Colors.white))),
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}
