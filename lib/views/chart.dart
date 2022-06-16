import 'package:flutter/material.dart';

class MoneySaverChart extends StatelessWidget {
  const MoneySaverChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Chart')),
        body: Column(
          children: const [
            Expanded(
              child: Text('Chart'),
            )
          ],
        ));
  }
}
