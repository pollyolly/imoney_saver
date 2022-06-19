import 'package:flutter/material.dart';
import 'package:imoney_saver/models/db_model.dart';
import 'package:imoney_saver/provider/detail_provider.dart';
import 'package:imoney_saver/views/widgets/list_card.dart';
import 'package:provider/provider.dart';

class MoneySaverList extends StatefulWidget {
  const MoneySaverList({Key? key}) : super(key: key);

  @override
  MoneySaverListState createState() => MoneySaverListState();
}

class MoneySaverListState extends State<MoneySaverList> {
  var db = DatabaseConnect();

  // late Future<List<MoneySaverModel>> dataList;

  // Future<List<dynamic>> getDataProvider() {
  //   var list = Provider.of<MoneySaverDetailProvider>(context, listen: false)
  //       .getDataProvider;
  //   return list;
  // }

  // @override
  // void initState() {
  //   dataList = db.getData(); //initialized once
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: FutureBuilder(
            future:
                Provider.of<MoneySaverDetailProvider>(context, listen: false)
                    .getDataProvider(),
            initialData: const [],
            builder: (context, snapshot) => snapshot.connectionState ==
                    ConnectionState.waiting
                ? const Center(
                    child: Text('no data found'),
                  )
                : Consumer<MoneySaverDetailProvider>(
                    builder: (context, detailProvider, child) =>
                        ListView.builder(
                          itemCount: detailProvider.dataList.length,
                          itemBuilder: (context, i) => MoneySaverCard(
                              id: detailProvider.dataList[i].id,
                              remarks: detailProvider.dataList[i].remarks,
                              money: detailProvider.dataList[i].money,
                              category: detailProvider.dataList[i].category,
                              creationDate:
                                  detailProvider.dataList[i].creationDate,
                              isChecked: detailProvider.dataList[i].isChecked),
                        ))));

    // @override
    // Widget build(BuildContext context) {
    //   return Expanded(
    //       child: FutureBuilder(
    //     future: dataList,
    //     initialData: const [],
    //     builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
    //       var data = snapshot.data;
    //       var datalength = data!.length;

    //       return datalength == 0
    //           ? const Center(
    //               child: Text('no data found'),
    //             )
    //           : ListView.builder(
    //               itemCount: datalength,
    //               itemBuilder: (context, i) => MoneySaverCard(
    //                   id: data[i].id,
    //                   remarks: data[i].remarks,
    //                   money: data[i].money,
    //                   category: data[i].category,
    //                   creationDate: data[i].creationDate,
    //                   isChecked: data[i].isChecked),
    //             );
    //     },
    //   ));
  }
}
