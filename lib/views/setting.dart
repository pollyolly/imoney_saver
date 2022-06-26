import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoneySaverSetting extends StatefulWidget {
  const MoneySaverSetting({Key? key}) : super(key: key);
  MoneySaverSettingState createState() => MoneySaverSettingState();
}

class MoneySaverSettingState extends State<MoneySaverSetting> {
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? selectedTime24Hour = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 10, minute: 47),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (selectedTime24Hour != null && selectedTime24Hour != selectedTime) {
      setState(() {
        selectedTime = selectedTime24Hour;
        print('Selected Time:' + selectedTime.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Setting')),
        body: Column(
          children: [
            Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0))),
                margin: const EdgeInsets.only(
                    top: 5, bottom: 5, left: 10, right: 10),
                child: InkWell(
                    onTap: () {},
                    child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Schedule Notification'),
                              Icon(Icons.timer, size: 25),
                            ])))),
            Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0))),
                margin: const EdgeInsets.only(
                    top: 5, bottom: 5, left: 10, right: 10),
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/theme-setting');
                    },
                    child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Theme'),
                              Icon(Icons.change_circle, size: 25),
                            ])))),
            Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0))),
                margin: const EdgeInsets.only(
                    top: 5, bottom: 5, left: 10, right: 10),
                child: InkWell(
                    onTap: () {},
                    child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Cloud backup'),
                              Icon(Icons.backup, size: 25),
                            ])))),
            Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0))),
                margin: const EdgeInsets.only(
                    top: 5, bottom: 5, left: 10, right: 10),
                child: InkWell(
                    onTap: () {},
                    child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Import/Export'),
                              Icon(Icons.import_export, size: 25),
                            ]))))
          ],
        ));
  }
}
