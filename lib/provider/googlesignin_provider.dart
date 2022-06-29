import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

//Scopes: https://developers.google.com/identity/protocols/oauth2/scopes#people

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId:
  //     '872338807730-934sqglpbrju06vp3b2f7s2rivh06rv9.apps.googleusercontent.com',
  scopes: [
    'email',
    // 'https://www.googleapis.com/auth/contacts.readonly',
    // 'https://www.googleapis.com/auth/userinfo.profile',
    // 'https://www.googleapis.com/auth/userinfo.email'
  ],
);

class GoogleSignInProvider with ChangeNotifier {
  GoogleSignInAccount? _currentUser;
  GoogleSignInAccount? get currentUser => _currentUser;

  GoogleSignInProvider() {
    initGoogle();
    // print('Google Signin Constructor called!');
  }

  Future<void> initGoogle() async {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      if (account != null) {
        _currentUser = account;
      } else {
        _currentUser = null;
      }
      // print('GSigin Provider init:' + _currentUser.toString());
    });
    _googleSignIn.signInSilently();
  }

  Future<void> googleSignin() async {
    try {
      await _googleSignIn.signIn();
      await initGoogle();
    } catch (error) {
      // print('GSignin Provider signin: ' + error.toString());
    }
  }

  Future<void> googleLogout() async {
    await _googleSignIn.disconnect();
    await initGoogle();
  }
}
