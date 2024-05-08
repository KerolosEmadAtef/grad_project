import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:test1/google_signin.dart';
// import 'package:test1/logout_screen.dart';
// import 'package:test1/main.dart';

class LoggedInPage extends StatelessWidget {
  final GoogleSignInAccount user;

  const LoggedInPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logged In Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              GoogleSignInApi.logout(); // Call the logout function
              Navigator.pop(context); // Navigate back to the previous screen
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, ${user.displayName}'),
            Text('Email: ${user.email}'),
            Text('User ID: ${user.id}'),
          ],
        ),
      ),
    );
  }
}
