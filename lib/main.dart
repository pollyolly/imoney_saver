import 'package:flutter/material.dart';
import 'package:imoney_saver/routes/route_generator.dart';
import 'package:imoney_saver/views/about.dart';
import 'package:imoney_saver/views/widgets/lists.dart';
import 'package:intl/intl.dart';
import 'package:mat_month_picker_dialog/mat_month_picker_dialog.dart';
// import 'models/db_model.dart';
// import 'models/money_saver_model.dart';
import 'net/notification_api.dart';
import 'views/widgets/navigation.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //await getDatabasesPath(); requirement
  // var db = DatabaseConnect();
  // await db.deleteAlldata();
  // await db.insertData(MoneySaverModel(
  //     remarks: 'Test income remarks',
  //     money: 100.45,
  //     category: 'Income',
  //     creationDate: DateTime.now(),
  //     isChecked: false));
  // // print(await db.getData());
  // await db.insertData(MoneySaverModel(
  //     remarks: 'Test income remarks',
  //     money: 200.34,
  //     category: 'Income',
  //     creationDate: DateTime.now(),
  //     isChecked: false));
  // await db.insertData(MoneySaverModel(
  //     remarks: 'Test expense remarks',
  //     money: 150.28,
  //     category: 'Expense',
  //     creationDate: DateTime.now(),
  //     isChecked: false));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  final String appTitle = "Flutter Demo";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: appTitle,
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ),
        // home: Home(),
        initialRoute: '/',
        onGenerateRoute: RouterGenerator.generateRoute);
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<Home> {
  // Home({Key? key}) : super(key: key);

  DateTime selectedDate = DateTime.now();
  final appName = const Text('Money Saver');
  String _month = 'January';

  @override
  void initState() {
    super.initState();
    NotificationApi.init();

    listenNotification();
  }

  void listenNotification() =>
      NotificationApi.onNotification.stream.listen(onClickNotification);
  void onClickNotification(String? payload) {
    //Do something you want when clicked notification
    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (context) => MoneySaverAbout(payload: payload)));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showMonthPicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _month = DateFormat("MMMM").format(picked).toString();
        // print(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: appName, actions: <Widget>[
        Text(_month,
            style: const TextStyle(
                height: 3, fontSize: 15, fontWeight: FontWeight.bold)),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: IconButton(
              onPressed: () => _selectDate(context),
              //
              icon: const Icon(Icons.calendar_month, size: 25)),
        ),
      ]),
      drawer: const NavigationDrawer(),
      body: Column(children: [MoneySaverList()]),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Details',
        onPressed: () => Navigator.of(context).pushNamed('/detail_add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
