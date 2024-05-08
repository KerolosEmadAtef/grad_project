import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'google_signin.dart';
import 'home_page.dart';
import 'loading_manager.dart';

class GoogleAuth {
  bool isLoading = false;

  Future signIn(BuildContext context) async {
    try {
      final user = await GoogleSignInApi.login();
      if (user != null) {
        await registerWithGoogle(user.displayName, user.email, user.id);
        print('User: $user');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(user: user),
          ),
        );
      } else {
        print('Login failed!');
      }
    } catch (error) {
      print('Error signing in with Google: $error');
    }
  }

  Future<void> registerWithGoogle(
      dynamic name, String email, String googleId) async {
    final String apiUrl =
        'https://graduation-api-zaj9.onrender.com/api/v1/user/google-register';

    final Map<String, String> requestBody = {
      'name': name,
      'email': email,
      'googleId': googleId,
    };

    try {
      loadingManager.setLoading(true);

      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        body: requestBody,
      );

      final Map<String, dynamic> responseData = json.decode(response.body);

      if (response.statusCode == 200 && responseData['success']) {
        loadingManager.setLoading(false);
        print('Registration successful!');
        // Navigate to the appropriate screen after successful registration
      } else {
        String errorMessage = responseData['msg'];
        print('Registration failed: $errorMessage');
        // Handle registration failure, display error message, etc.
        loadingManager.setLoading(false);
      }
    } catch (error) {
      print('Error during registration: $error');
      loadingManager.setLoading(false);
    }
  }
}
