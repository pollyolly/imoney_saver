import 'package:flutter/material.dart';
import 'package:imoney_saver/models/db_model.dart';
import 'package:imoney_saver/models/money_saver_arguments.dart';
import 'package:imoney_saver/models/money_saver_model.dart';
import 'package:imoney_saver/net/notification_api.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class MoneySaverUpdateDetail extends StatefulWidget {
  // final TextEditingController controller;
  MoneySaverArguments data;
  MoneySaverUpdateDetail({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  MoneySaverUpdateDetailState createState() => MoneySaverUpdateDetailState();
}

class MoneySaverUpdateDetailState extends State<MoneySaverUpdateDetail> {
  var db = DatabaseConnect();
  DateTime selectedDate = DateTime.now();
  String _month = "";
  String dropdownValue = '';
  IconData texticon = Icons.add;
  var moneyText = TextEditingController();
  var remarksText = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    // print(widget.data.creationDate);
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _month = DateFormat("MMM/d").format(picked).toString();
        // print(picked);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    texticon =
        (widget.data.category == 'Expense') ? Icons.horizontal_rule : Icons.add;
    moneyText = TextEditingController(text: widget.data.money.toString());
    remarksText = TextEditingController(text: widget.data.remarks.toString());
  }

  @override
  void dispose() {
    moneyText.dispose();
    remarksText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Update Details'),
          actions: [
            DropdownButton<String>(
              value:
                  dropdownValue.isEmpty ? widget.data.category : dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              elevation: 10,
              style: const TextStyle(
                  height: 2.5,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['Expense', 'Income']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            )
          ],
        ),
        body: Card(
          margin: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
          child: Container(
            margin:
                const EdgeInsets.only(top: 5, bottom: 0, left: 10, right: 10),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    height: 60,
                    width: 310,
                    child: Center(
                      child: TextFormField(
                        controller: remarksText,
                        autofocus: false,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 15),
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
                      ),
                    )),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 70,
                      width: 30,
                      child: Center(
                        child: Icon(texticon),
                      ),
                    ),
                    SizedBox(
                        height: 60,
                        width: 250,
                        child: Center(
                          child: TextFormField(
                            controller: moneyText,
                            autofocus: false,
                            readOnly: true,
                            enableInteractiveSelection: false,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 30),
                            decoration: const InputDecoration(
                                border: OutlineInputBorder()),
                          ),
                        )),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                        height: 40,
                        child: Row(
                          children: [
                            NumberButton(
                              number: 7,
                              size: 70,
                              color: Colors.indigo,
                              controller: moneyText,
                            ),
                            NumberButton(
                              number: 8,
                              size: 70,
                              color: Colors.indigo,
                              controller: moneyText,
                            ),
                            NumberButton(
                              number: 9,
                              size: 70,
                              color: Colors.indigo,
                              controller: moneyText,
                            ),
                            SizedBox(
                              height: 70,
                              width: 100,
                              child: ElevatedButton(
                                onPressed: () => _selectDate(context),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10 / 2),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    _month.isEmpty
                                        ? DateFormat("MMM/d")
                                            .format(widget.data.creationDate)
                                            .toString()
                                        : _month,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                        height: 40,
                        child: Row(
                          children: [
                            NumberButton(
                              number: 4,
                              size: 70,
                              color: Colors.indigo,
                              controller: moneyText,
                            ),
                            NumberButton(
                              number: 5,
                              size: 70,
                              color: Colors.indigo,
                              controller: moneyText,
                            ),
                            NumberButton(
                              number: 6,
                              size: 70,
                              color: Colors.indigo,
                              controller: moneyText,
                            ),
                            SizedBox(
                              height: 70,
                              width: 100,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    dropdownValue = 'Expense';
                                    texticon = Icons.horizontal_rule;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10 / 2),
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    '-',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 30),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                        height: 40,
                        child: Row(
                          children: [
                            NumberButton(
                              number: 1,
                              size: 70,
                              color: Colors.indigo,
                              controller: moneyText,
                            ),
                            NumberButton(
                              number: 2,
                              size: 70,
                              color: Colors.indigo,
                              controller: moneyText,
                            ),
                            NumberButton(
                              number: 3,
                              size: 70,
                              color: Colors.indigo,
                              controller: moneyText,
                            ),
                            SizedBox(
                              height: 70,
                              width: 100,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    dropdownValue = 'Income';
                                    texticon = Icons.add;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10 / 2),
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    '+',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 30),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                        height: 40,
                        child: Row(
                          children: [
                            SizedBox(
                              height: 70,
                              width: 70,
                              child: ElevatedButton(
                                onPressed: () {
                                  moneyText.text += ".";
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10 / 2),
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    '.',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 30),
                                  ),
                                ),
                              ),
                            ),
                            NumberButton(
                              number: 0,
                              size: 70,
                              color: Colors.indigo,
                              controller: moneyText,
                            ),
                            SizedBox(
                                height: 70,
                                width: 70,
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (moneyText.text.isNotEmpty) {
                                        moneyText.text = moneyText.text
                                            .substring(
                                                0, moneyText.text.length - 1);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10 / 2),
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.backspace,
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                    ))),
                            SizedBox(
                                height: 70,
                                width: 100,
                                child: ElevatedButton(
                                    onPressed: () async {
                                      Future<MoneySaverModel> result =
                                          db.updateData(MoneySaverModel(
                                              id: widget.data.id,
                                              remarks: remarksText.text,
                                              money:
                                                  double.parse(moneyText.text),
                                              category: dropdownValue,
                                              creationDate: selectedDate,
                                              isChecked: false));
                                      await result.then((value) {
                                        NotificationApi.showNotification(
                                            title: 'Successfully Updated!',
                                            body: value.remarks,
                                            payload: 'test payload');
                                      });
                                      // controller.text += number.toString();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10 / 2),
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                    ))),
                            // ),
                          ],
                        )),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

class NumberButton extends StatelessWidget {
  final int number;
  final double size;
  final Color color;
  final TextEditingController controller;
  const NumberButton(
      {Key? key,
      required this.number,
      required this.size,
      required this.color,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ElevatedButton(
        onPressed: () {
          controller.text += number.toString();
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10 / 2),
          ),
        ),
        child: Center(
          child: Text(
            number.toString(),
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30),
          ),
        ),
      ),
    );
  }
}
