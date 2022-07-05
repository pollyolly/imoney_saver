import 'package:firebase_auth/firebase_auth.dart'; //AuthCredential
import 'package:flutter/material.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:imoney_saver/net/secured_storage.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:imoney_saver/net/notification_api.dart'; //IOClient
//https://preneure.com/upload-files-in-google-drive-using-flutter/

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    drive.DriveApi.driveAppdataScope,
    drive.DriveApi.driveFileScope
  ],
);

class GoogleSignInProvider with ChangeNotifier {
  GooleAuthSecureStorage storeAuth = GooleAuthSecureStorage();
  GoogleSignInAccount? _currentUser;
  // GoogleSignInAccount? _user;
  GoogleSignIn? googleUser;
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _filepath;
  String? get filepath => _filepath;
  GoogleSignInAccount? get currentUser => _currentUser;

  GoogleSignInProvider() {
    initGoogle();
    // print('Google Signin Constructor called!');
  }

  Future<void> initGoogle() async {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      if (account != null) {
        _currentUser = account;
        _afterGoogleLogin(account);
      } else {
        _currentUser = null;
      }
    });
    _googleSignIn.signInSilently();
  }

  Future<void> googleSignin() async {
    try {
      await _googleSignIn.signIn();
      await initGoogle();
    } catch (error) {}
  }

  Future<void> googleLogout() async {
    await _googleSignIn.disconnect();
    await initGoogle();
    storeAuth.clear();
  }

  Future<void> uploadFileToGoogleDrive() async {
    var client = GoogleHttpClient(await _currentUser!.authHeaders);
    var drive2 = drive.DriveApi(client);
    drive.File fileToUpload = drive.File();
    FilePickerResult? fresult = await FilePicker.platform.pickFiles();

    if (fresult != null) {
      PlatformFile? file = fresult.files.first;
      fileToUpload.parents = [
        "1nESDN0z_en_3sW_XNCWXtfQmawULUtUt"
      ]; //imoney_saver_backup
      fileToUpload.name = file.name;
      File data = File(fresult.files.single.path!);
      var response = await drive2.files.create(fileToUpload,
          uploadMedia: drive.Media(data.openRead(), data.lengthSync()));
      // _filepath = file.path;
      // print(response);
      await NotificationApi.showNotification(
          title: 'Google Drive Upload',
          body: 'Failed to upload: $response',
          payload: 'test payload');
    } else {
      await NotificationApi.showNotification(
          title: 'Google Drive Upload',
          body: 'Failed to upload: ${fresult?.files.first.name}',
          payload: 'test payload');
    }
  }
//For Testing Stream Upload //Working
  // Future<void> uploadFileToGoogleDrive() async {
  //   var client = GoogleHttpClient(await _currentUser!.authHeaders);
  //   var drive2 = drive.DriveApi(client);
  //   var fileToUpload = drive.File();
  //   fileToUpload.parents = [
  //     "1nESDN0z_en_3sW_XNCWXtfQmawULUtUt"
  //   ]; //imoney_saver_backup
  //   fileToUpload.name = "hello_world.txt";
  //   final Stream<List<int>> mediaStream =
  //       Future.value([104, 105]).asStream().asBroadcastStream();
  //   await drive2.files
  //       .create(fileToUpload, uploadMedia: drive.Media(mediaStream, 2));
  // }

  Future<void> _afterGoogleLogin(GoogleSignInAccount gSA) async {
    _currentUser = gSA;

    final GoogleSignInAuthentication? googleSignInAuth =
        await _currentUser?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuth?.idToken,
        accessToken: googleSignInAuth?.accessToken);
    FirebaseAuth auth = FirebaseAuth.instance;

    final Future<UserCredential> authResult =
        auth.signInWithCredential(credential);
    final Future<User?> user = authResult.then((value) => value.user);
    Future<bool?> isanonymous = user.then((value) => value?.isAnonymous);
    assert(isanonymous == false);

    final User? curuser = auth.currentUser;
    var useruid = user.then((value) => value?.uid);

    assert(useruid == curuser?.uid);

    //   await storeAuth.saveCredentials({
    //     'accessToken': googleSignInAuth?.accessToken,
    //     'name': _currentUser?.displayName,
    //     'email': _currentUser?.email,
    //     'photo': _currentUser?.photoUrl
    //   });
  }
}

class GoogleHttpClient extends IOClient {
  final Map<String, String> _headers;
  GoogleHttpClient(this._headers) : super();
  @override
  Future<IOStreamedResponse> send(http.BaseRequest request) =>
      super.send(request..headers.addAll(_headers));
  @override
  Future<http.Response> head(Uri url, {Map<String, String>? headers}) =>
      super.head(url, headers: headers?..addAll(_headers));
}
