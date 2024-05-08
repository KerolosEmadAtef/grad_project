import 'package:flutter/material.dart';
import 'api_service_reset_password.dart';
import 'reset_password_token_entry.dart';
import 'utils.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({Key? key}) : super(key: key);

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final TextEditingController emailResetController = TextEditingController();
  final TextEditingController passwordResetController = TextEditingController();

  @override
  void dispose() {
    emailResetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF1D65FF),
          ),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous page
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30.0,
              ),
              Row(
                children: [
                  Text(
                    'Forgot your password?',
                    style: TextStyle(
                        color: Color(0xFF1D65FF),
                        fontSize: 28.0,
                        fontWeight: FontWeight.w800),
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'Please, enter your email address to reset your password.',
                style: TextStyle(fontSize: 18.0, color: Colors.grey[700]),
              ),
              SizedBox(height: 40.0),
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: emailResetController,
                onChanged: (value) {
                  // Reset error when user starts typing
                  // setState(() {
                  // });
                  emailError = false;
                },
                onEditingComplete: () {
                  // Move the focus to the password field when editing is complete
                  FocusScope.of(context).nextFocus();
                },
                decoration: InputDecoration(
                  // prefixIcon: Image(
                  //   image: AssetImage('lib/icons/icons8-email-24.png'),
                  // ),
                  prefixIcon: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Color.fromARGB(255, 135, 135,
                          135), // Set the fixed color for the prefix icon
                      BlendMode.srcIn,
                    ),
                    child: Icon(Icons.email_outlined),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                        color: emailError
                            ? Colors.red
                            : Colors.blue), // Set border color when focused
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 240, 240, 240),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: emailError ? Colors.red : Colors.transparent),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  labelText: 'Email',
                  labelStyle: TextStyle(
                      color: emailError ? Colors.red : Color(0xFF535353)),
                ),
              ),
              SizedBox(height: 140.0),
              GestureDetector(
                onTap: () async {
                  String email = emailResetController.text.trim();

                  try {
                    final response =
                        await ResetPassword.getResetPasswordToken(email);

                    if (response['success']) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(response['msg']),
                        ),
                      );
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PasswordTokenEntryPage(),
                          ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(response['msg']),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('Failed to reset password. Please try again.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Color(0xFF1D65FF),
                  ),
                  width: double.infinity,
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: isLoading
                        ? SizedBox(
                            width: 23.0,
                            height: 23.0,
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(
                            'Next',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
