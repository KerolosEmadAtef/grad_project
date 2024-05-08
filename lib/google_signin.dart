import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:test1/loggedin_screen.dart';

Future signIn(BuildContext context) async {
  try {
    final user = await GoogleSignInApi.login();
    if (user != null) {
      print('$user');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoggedInPage(user: user),
        ),
      );
    } else {
      print('Login failed!');
    }
  } catch (error) {
    print('Error signing in with Google: $error');
  }
}

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn();

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();

  static Future<void> logout() async {
    _googleSignIn.disconnect();
  }
}
