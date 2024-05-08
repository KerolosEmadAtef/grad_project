// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:shared_preferences/shared_preferences.dart';

class LoginModel {
  dynamic email;
  dynamic password;

  LoginModel({this.email, this.password});

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}

class SignupModel {
  dynamic userName;
  dynamic email;
  dynamic password;

  SignupModel({
    this.userName,
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() => {
        'name': userName,
        'email': email,
        'password': password,
      };
}

class ForgetPasswordModel {
  dynamic email;

  ForgetPasswordModel({
    this.email,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
      };
}

class ResetPasswordModel {
  dynamic token;
  dynamic password;

  ResetPasswordModel({this.token, this.password});

  Map<String, dynamic> toJson() => {'token': token, 'password': password};
}

class UserLogoutModel {
  dynamic token;

  UserLogoutModel({
    this.token,
  });

  Map<String, dynamic> toJson() => {
        'token': token,
      };
  factory UserLogoutModel.fromAccessToken(SharedPreferences prefs) {
    String accessToken = prefs.getString('accessToken') ?? '';
    return UserLogoutModel(token: accessToken);
  }
}

// class LoginModel {
//   bool? success;
//   String? message;
//   String? refreshToken;
//   String? token;

//   LoginModel({this.success, this.message, this.refreshToken, this.token});

//   LoginModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     message = json['msg'];
//     refreshToken = json['refresh_token'];
//     token = json['token'];
//     // We sould store this token in the shared preferences!
//   }
// }
