import 'package:flutter/material.dart';

class MoneySaverSetting extends StatelessWidget {
  const MoneySaverSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Setting')),
        body: Column(
          children: const [
            Expanded(
              child: Text('Setting'),
            )
          ],
        ));
  }
}
