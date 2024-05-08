import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:test1/loggedin_screen.dart';
// import 'package:i_home_control/signup_screen.dart';
import 'dart:convert';
import 'google_auth.dart';
import 'home_page.dart';
import 'password_reset.dart';
import 'signup_ui.dart';
import 'utils.dart';

class LoginScreenO extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreenO> {
  // final TextEditingController emailController = TextEditingController();
  // final TextEditingController passwordController = TextEditingController();
  GoogleAuth googleAuth = GoogleAuth();
  // bool emailError = false;
  // bool passwordError = false;
  // bool isLoading = false;
  bool _isObscure = true;

  get googleSignInAccount => null;

  void _removeFocus() {
    // Unfocus the text fields when called
    FocusScope.of(context).unfocus();
  }

  Future<void> _login() async {
    if (emailController.text.isEmpty) {
      setState(() {
        emailError = true;
      });
      _showErrorPopup('Email is required');
      return;
    }

    if (passwordController.text.isEmpty) {
      setState(() {
        passwordError = true;
      });
      _showErrorPopup('Password is required');
      return;
    }

    final String apiUrl =
        'https://graduation-api-zaj9.onrender.com/api/v1/user/login';

    final Map<String, String> requestBody = {
      'email': emailController.text,
      'password': passwordController.text,
    };

    try {
      setState(() {
        isLoading = true; // Set loading state to true when the request starts
      });

      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        body: requestBody,
      );

      final Map<String, dynamic> responseData = json.decode(response.body);

      if (response.statusCode == 200 && responseData['success']) {
        setState(() {
          emailError = false;
          passwordError = false;
          isLoading = false;
        });

        String authToken = responseData['token'];
        print('Login successful!, Token: $authToken');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(user: googleSignInAccount)),
        );
      } else {
        String errorMessage = responseData['msg'];
        print('Oops!: $errorMessage');

        if (errorMessage.toLowerCase().contains('email')) {
          setState(() {
            emailError = true;
          });
        } else if (errorMessage.toLowerCase().contains('password')) {
          setState(() {
            passwordError = true;
          });
        }
        setState(() {
          isLoading = false;
        });
        // _showErrorPopup(errorMessage);
      }
    } catch (error) {
      print('Error during login: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showErrorPopup(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Oops!'),
          content: Text(errorMessage + ', Please try again!'),
          backgroundColor: Colors.grey[100],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _removeFocus,
        child: ListView(
          // controller: _scrollController,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Align(
                    child: Image(
                      image: AssetImage(
                        'lib/icons/Smart home-bro.png',
                      ),
                      height: 260.0,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                            color: Color(0xFF1D65FF),
                            fontSize: 26.0,
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    onChanged: (value) {
                      // Reset error when user starts typing
                      setState(() {
                        emailError = false;
                      });
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
                            color:
                                emailError ? Colors.red : Colors.transparent),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      labelText: 'Email',
                      labelStyle: TextStyle(
                          color: emailError ? Colors.red : Color(0xFF535353)),
                    ),
                  ),
                  if (emailError)
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                          child: Text(
                            'Email is incorrect',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: passwordController,
                    onChanged: (value) {
                      // Reset error when user starts typing
                      setState(() {
                        passwordError = false;
                      });
                    },
                    obscureText: _isObscure,
                    onEditingComplete: () {
                      // You can handle the editing completion for the password field here
                      FocusScope.of(context).unfocus();
                      // _login();
                    },
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color:
                                    passwordError ? Colors.red : Colors.blue),
                            borderRadius: BorderRadius.circular(12.0)),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        // prefixIcon: Image(
                        //     image:
                        //         AssetImage('lib/icons/icons8-password-24.png')),
                        prefixIcon: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Color.fromARGB(255, 135, 135,
                                135), // Set the fixed color for the prefix icon
                            BlendMode.srcIn,
                          ),
                          child: Icon(Icons.lock_outline),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                          child: Icon(
                            _isObscure
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Color.fromARGB(255, 135, 135, 135),
                          ),
                        ),
                        filled: true,
                        fillColor: Color.fromARGB(255, 240, 240, 240),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: passwordError
                                    ? Colors.red
                                    : Colors.transparent),
                            borderRadius: BorderRadius.circular(12.0)),
                        labelText: 'Password',
                        labelStyle: TextStyle(
                            color: passwordError
                                ? Colors.red
                                : Color(0xFF535353))),
                  ),
                  if (passwordError)
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                          child: Text(
                            'Password is incorrect',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 8.0),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PasswordResetPage()),
                    ),
                    child: Text(
                      'Forgot your password?',
                      style: TextStyle(color: Color(0xFF1D65FF)),
                    ),
                  ),
                  SizedBox(height: 24.0),
                  GestureDetector(
                    onTap: () {
                      // Add your login logic here
                      // login(context, emailController, passwordController)
                      //     .then((value) => {
                      //           if (value == true)
                      //             Navigator.push(
                      //               context,
                      //               MaterialPageRoute(
                      //                   builder: (context) => HomePage(
                      //                       user: googleSignInAccount)),
                      //             )
                      //         });
                      _login();
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
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )
                            : Text(
                                'Sign in',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 12.0),
                          child: Divider(
                            color: Colors.black, // Set the color of the line
                            thickness: 1.0, // Set the thickness of the line
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text("OR"),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 12.0),
                          child: Divider(
                            color: Colors.black, // Set the color of the line
                            thickness: 1.0, // Set the thickness of the line
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      googleAuth.signIn(context);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xFF1D65FF)), // Add border styling
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'lib/icons/google.png', // Replace with the path to your Google image
                            height: 24.0,
                            width: 24.0,
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            'Continue with Google',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                      SizedBox(width: 4.0), // Add some space between the texts
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpScreen(),
                              ));
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: Color(0xFF1D65FF)),
                        ),
                      ),
                    ],
                  ),
                  //add continue with google here
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
