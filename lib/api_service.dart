import 'package:http/http.dart' as http;
import 'dart:convert';

class APIService {
  static Future<Map<String, dynamic>> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    final String apiUrl =
        'https://graduation-api-zaj9.onrender.com/api/v1/user/register';

    final Map<String, String> requestBody = {
      'name': name,
      'email': email,
      'password': password,
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        body: requestBody,
      );

      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData;
    } catch (error) {
      print('Error during user registration: $error');
      throw error;
    }
  }

  //-----------------------------------------------------------------

  static Future<Map<String, dynamic>> registerWithGoogle({
    required String displayName,
    required String email,
    required String googleId,
  }) async {
    final String apiUrl =
        'https://graduation-api-zaj9.onrender.com/api/v1/user/google-register';

    final Map<String, dynamic> requestBody = {
      'name': displayName,
      'email': email,
      'googleId': googleId,
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData;
    } catch (error) {
      print('Error during Google registration: $error');
      throw error;
    }
  }
}
