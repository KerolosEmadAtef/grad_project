import 'package:flutter/material.dart';
import 'api_service_reset_password.dart';
import 'login_screen.dart';

class ResetPasswordPage extends StatefulWidget {
  final String token;

  ResetPasswordPage({required this.token});

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Token received: ${widget.token}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Enter New Password',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                String newPassword = _passwordController.text;
                await ResetPassword.resetPassword(widget.token, newPassword);
                try {
                  // final response = await ResetPassword.resetPassword(
                  // widget.token, newPassword);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreenO(),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'You have successfully confirmed your new password!'),
                      backgroundColor: Colors.blue[400],
                    ),
                  );
                } catch (e) {
                  // Show error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Failed to reset password. Please try again.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}
