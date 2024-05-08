import 'package:flutter/material.dart';

class LogoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logout Message'),
      ),
      body: Center(
        child: Text(
          'You have just logged out.',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
