import 'package:flutter/material.dart';
import 'package:imoney_saver/models/db_model.dart';

import 'list_card.dart';

// ignore: must_be_immutable
class MoneySaverList extends StatelessWidget {
  var db = DatabaseConnect();
  MoneySaverList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: FutureBuilder(
      future: db.getData(),
      initialData: const [],
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        var data = snapshot.data;
        var datalength = data!.length;

        return datalength == 0
            ? const Center(
                child: Text('no data found'),
              )
            : ListView.builder(
                itemCount: datalength,
                itemBuilder: (context, i) => MoneySaverCard(
                    id: data[i].id,
                    remarks: data[i].remarks,
                    money: data[i].money,
                    // incomeMoney: data[i].incomeMoney,
                    // expenseMoney: data[i].expenseMoney,
                    category: data[i].category,
                    creationDate: data[i].creationDate,
                    isChecked: data[i].isChecked),
              );
      },
    ));
  }
}
