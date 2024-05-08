import 'package:http/http.dart' as http;

class ResetPassword {
  static Future<Map<String, dynamic>> getResetPasswordToken(
      String email) async {
    final url = Uri.parse(
        'https://graduation-api-zaj9.onrender.com/api/v1/user/forget-password');
    final response = await http.post(
      url,
      body: {'email': email},
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON response
      return {
        'success': true,
        'msg': 'Please check your inbox for resetting your password',
      };
    } else {
      // If the server returns an error response, throw an exception
      throw Exception('Failed to reset password');
    }
  }

  static Future<bool> resetPassword(String token, String newPassword) async {
    final url =
        'https://graduation-api-zaj9.onrender.com/api/v1/user/reset-password';
    final response = await http.post(
      Uri.parse(url),
      body: {
        'token': token,
        'password': newPassword,
      },
    );

    if (response.statusCode == 200) {
      // Password reset successful
      return true;
    } else {
      // Password reset failed
      return false;
    }
  }
}
