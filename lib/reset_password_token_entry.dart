import 'package:flutter/material.dart';
import 'reset_password_entry.dart'; // Import the page for new password entry

class PasswordTokenEntryPage extends StatefulWidget {
  @override
  _TokenEntryPageState createState() => _TokenEntryPageState();
}

class _TokenEntryPageState extends State<PasswordTokenEntryPage> {
  late TextEditingController _tokenController;

  @override
  void initState() {
    super.initState();
    _tokenController = TextEditingController();
  }

  @override
  void dispose() {
    _tokenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Token'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _tokenController,
              decoration: InputDecoration(
                labelText: 'Enter Token',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                String token = _tokenController.text;
                // Navigate to the page for new password entry and pass the token
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResetPasswordPage(token: token),
                  ),
                );
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
