import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
      const DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.yellow,
        ),
        child: Text('Money Saver'),
      ),
      ListTile(
          title: const Text('Charts'),
          onTap: () {
            // Navigator.pop(context);
            Navigator.of(context).pushNamed('/chart');
          }),
      ListTile(
          title: const Text('Settings'),
          onTap: () {
            // Navigator.pop(context);
            Navigator.of(context).pushNamed('/setting');
          }),
      ListTile(
          title: const Text('About'),
          onTap: () {
            // Navigator.pop(context);
            Navigator.of(context).pushNamed('/about');
          }),
      ListTile(
          title: const Text('Rate'),
          onTap: () {
            Navigator.of(context).pushNamed('/rate');
          }),
    ]));
  }
}
