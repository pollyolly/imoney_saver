import 'package:flutter/material.dart';
import 'package:imoney_saver/ui/theme.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
      const DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.orange,
        ),
        child: Text('Money Saver'),
      ),
      ListTile(
          title: const Text('Charts'),
          onTap: () {
            Navigator.of(context).pushNamed('/chart');
          }),
      ListTile(
          title: const Text('Settings'),
          onTap: () {
            Navigator.of(context).pushNamed('/setting');
          }),
      ListTile(
          title: const Text('About'),
          onTap: () {
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
