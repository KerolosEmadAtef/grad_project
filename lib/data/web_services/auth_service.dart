import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/auth_models.dart';

class SignInResponse {
  final Response response;
  final String accessToken;
  final String refreshToken;

  SignInResponse({
    required this.response,
    required this.accessToken,
    required this.refreshToken,
  });
}

class ApiServices {
  SharedPreferences? prefs;
  ApiServices({this.prefs});

  Future<dynamic> signinPostRequest(LoginModel model) async {
    String endPoint =
        'https://graduation-api-zaj9.onrender.com/api/v1/user/login';
    Response response;
    Dio dio = Dio();

    response = await dio.post(
      endPoint,
      data: model.toJson(),
    );
    bool loginSuccess;
    bool success;
    success = response.data['success'];
    if (success == true) {
      print('Successful Response');
      print('Response: ${response.data}');

      String accessToken = response.data['token'];
      String refreshToken = response.data['refresh_token'];

      prefs?.setString('accessToken', accessToken);
      prefs?.setString('refreshToken', refreshToken);

      print('Access Token: $accessToken');
      print('Refresh Token: $refreshToken');

      return response;
    } else {
      loginSuccess = false;
      return loginSuccess;
      // log('Error: ${response.statusCode}');
      // log(response.data['msg']);
    }
    // ignore: deprecated_member_use
  }

  Future<int?> signupPostRequest(SignupModel model) async {
    String endPoint =
        'https://graduation-api-zaj9.onrender.com/api/v1/user/register';
    Response response;
    try {
      Dio dio = Dio();
      response = await dio.post(
        endPoint,
        data: model.toJson(),
      );
      if (response.statusCode == 200) {
        print('Successful Response');
        print('Response: ${response.data}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<int?> forgetPasswordPostRequest(ForgetPasswordModel model) async {
    String endPoint =
        'https://graduation-api-zaj9.onrender.com/api/v1/user/forget-password';
    Response response;
    try {
      Dio dio = Dio();
      response = await dio.post(
        endPoint,
        data: model.toJson(),
      );
      if (response.statusCode == 200) {
        print('Successful Response');
        print('Response: ${response.data}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<int?> resetPasswordPostRequest(ResetPasswordModel model) async {
    String endPoint =
        'https://graduation-api-zaj9.onrender.com/api/v1/user/reset-password';
    Response response;
    try {
      Dio dio = Dio();
      response = await dio.post(
        endPoint,
        data: model.toJson(),
      );
      if (response.statusCode == 200) {
        print('Successful Response');
        print('Response: ${response.data}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<int?> userLogoutPostRequest(SharedPreferences prefs) async {
    String endPoint =
        'https://graduation-api-zaj9.onrender.com/api/v1/user/logout';
    Response response;
    try {
      Dio dio = Dio();
      UserLogoutModel logoutModel = UserLogoutModel.fromAccessToken(prefs);
      response = await dio.post(
        endPoint,
        data: logoutModel.toJson(),
      );
      if (response.statusCode == 200) {
        print('Successful Response');
        print('Response: ${response.data}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
