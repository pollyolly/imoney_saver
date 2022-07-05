import 'package:flutter/material.dart';
import 'package:imoney_saver/provider/googlesignin_provider.dart';
import 'package:provider/provider.dart';

class BackupSetting extends StatefulWidget {
  const BackupSetting({Key? key}) : super(key: key);
  @override
  BackupSettingState createState() => BackupSettingState();
}

class BackupSettingState extends State<BackupSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Backup Setting')),
        body: Column(
          children: [
            Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0))),
                margin: const EdgeInsets.only(
                    top: 5, bottom: 5, left: 10, right: 10),
                child: Consumer<GoogleSignInProvider>(
                    builder: (context, googleProvider, child) {
                  return InkWell(
                      onTap: () {
                        googleProvider.uploadFileToGoogleDrive();
                      },
                      child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Google Drive:${googleProvider.filepath}')
                              ])));
                })
                // ),
                ),
          ],
        ));
  }
}
