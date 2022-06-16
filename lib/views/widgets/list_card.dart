import 'package:flutter/material.dart';
import 'package:imoney_saver/models/money_saver_arguments.dart';
import 'package:intl/intl.dart';

class MoneySaverCard extends StatefulWidget {
  final int id;
  final String remarks;
  final num money;
  // final num incomeMoney;
  // final num expenseMoney;
  final String category;
  final DateTime creationDate;
  final dynamic isChecked; //set dynamic data type
  final DateFormat formatter = DateFormat('MM/dd EEE'); //intl.dart

  MoneySaverCard(
      {required this.id,
      required this.remarks,
      required this.money,
      // required this.incomeMoney,
      // required this.expenseMoney,
      required this.category,
      required this.creationDate,
      required this.isChecked,
      Key? key})
      : super(key: key);

  @override
  MoneySaverState createState() => MoneySaverState();
}

class MoneySaverState extends State<MoneySaverCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
        child: Row(children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/detail',
                      arguments: MoneySaverArguments(
                          widget.id,
                          widget.remarks,
                          widget.money,
                          // widget.incomeMoney,
                          // widget.expenseMoney,
                          widget.category,
                          widget.creationDate,
                          widget.isChecked));
                },
                icon: widget.category == 'Expense'
                    ? const Icon(Icons.arrow_downward,
                        size: 35, color: Color(0xFFFF1744))
                    : const Icon(Icons.arrow_upward,
                        size: 35, color: Color(0xFF00E676))),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Container(
                  Text(widget.formatter.format(widget.creationDate).toString(),
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xFF8F8F8F))),
                  // ),
                  Row(
                    children: [
                      Text(
                        "${widget.category}: ",
                        style: const TextStyle(
                            fontSize: 12, color: Color(0xFF8F8F8F)),
                      ),
                      Text(
                        widget.category == 'Expense'
                            ? '-${widget.money}'
                            : '+${widget.money}',
                        style: const TextStyle(
                            fontSize: 12, color: Color(0xFF8F8F8F)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  )
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                    overflow: TextOverflow.ellipsis,
                    widget.remarks,
                    style: const TextStyle(fontSize: 15)),
                // const SizedBox(
                //   height: 10,
                // ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Text(
                    widget.category == 'Expense'
                        ? '-${widget.money}'
                        : '+${widget.money}',
                    style:
                        const TextStyle(fontSize: 15, color: Color(0xFF8F8F8F)),
                  ),
                )
                // const SizedBox(
                //   width: 0,
                // ),
              ])
            ],
          )),
        ]));
  }
}
