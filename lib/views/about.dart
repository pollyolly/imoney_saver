import 'package:flutter/material.dart';

class MoneySaverAbout extends StatelessWidget {
  const MoneySaverAbout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('About')),
        body: Column(
          children: const [
            Expanded(
              child: Text('About'),
            )
          ],
        ));
  }
}
