import 'package:flutter/material.dart';
import 'package:imoney_saver/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(child: Consumer<MoneySaverThemeProvider>(
        builder: (context, MoneySaverThemeProvider value, child) {
      return ListView(padding: EdgeInsets.zero, children: [
        DrawerHeader(
          decoration: BoxDecoration(
              color: value.darkTheme ? Colors.black12 : Colors.orange),
          child: Text(
            'Money Saver',
            style:
                TextStyle(color: value.darkTheme ? Colors.grey : Colors.white),
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
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
      ]);
    }));
  }
}
