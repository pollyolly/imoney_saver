import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:imoney_saver/models/money_saver_arguments.dart';
import 'package:imoney_saver/models/db_model.dart';

// ignore: must_be_immutable
class MoneySaverDetails extends StatelessWidget {
  MoneySaverArguments data;
  final DateFormat formatter = DateFormat('MMMM/dd/yyyy EEE');
  var db = DatabaseConnect();
  MoneySaverDetails({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: Card(
          margin:
              const EdgeInsets.only(top: 5, bottom: 340, left: 10, right: 10),
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              // child: Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 10,
                        width: 10,
                      ),
                      IconButton(
                          tooltip: 'Delete Details',
                          onPressed: () {
                            showAlertDialog(context);
                          },
                          icon: const Icon(Icons.delete_outline_outlined))
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: 40,
                          child: Row(
                            children: [
                              const Text('Category:',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF8F8F8F))),
                              Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(data.category,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: Color(0xFF8F8F8F)))),
                            ],
                          )),
                      SizedBox(
                          height: 40,
                          child: Row(
                            children: [
                              const Text('Money:',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF8F8F8F))),
                              Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                      data.category == 'Expense'
                                          ? '-${data.money}'
                                          : '+${data.money}',
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: Color(0xFF8F8F8F)))),
                            ],
                          )),
                      SizedBox(
                          height: 40,
                          child: Row(
                            children: [
                              const Text('Created:',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF8F8F8F))),
                              Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                      formatter
                                          .format(data.creationDate)
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: Color(0xFF8F8F8F)))),
                            ],
                          )),
                      SizedBox(
                          height: 40,
                          child: Row(
                            children: [
                              const Text('Remarks:',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF8F8F8F))),
                              Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(data.remarks,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: Color(0xFF8F8F8F)))),
                            ],
                          ))
                    ],
                  )
                ],
              )
              // )
              )),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Edit Details',
        onPressed: () => Navigator.of(context).pushNamed('/update-detail',
            arguments: MoneySaverArguments(
              data.id,
              data.remarks,
              data.money,
              // data.incomeMoney,
              // data.expenseMoney,
              data.category,
              data.creationDate,
              data.isChecked,
            )),
        child: const Icon(Icons.edit),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget okButton = FlatButton(
      child: const Text("Ok"),
      onPressed: () {
        // db.deleteData(MoneySaverModel data);
        Navigator.of(context).pop(); // dismiss dialog
      },
    );
    Widget cancelButton = FlatButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Notice"),
      content: const Text("Do you really want to continue this action?"),
      actions: [
        okButton,
        cancelButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
