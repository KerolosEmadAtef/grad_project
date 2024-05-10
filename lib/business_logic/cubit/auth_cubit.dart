import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'auth_state.dart';
import 'package:test1/data/web_services/auth_service.dart'; // Import your authentication service
import 'package:test1/data/models/auth_models.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import your authentication models

class AuthCubit extends Cubit<AuthState> {
  final ApiServices apiServices;
  SharedPreferences? prefs;

  AuthCubit({required this.apiServices}) : super(AuthInitial());

  // Method to sign in the user
  Future<void> signIn(LoginModel data) async {
    emit(AuthLoading()); // Emit loading state
    Either<String, Response> result = await apiServices.signinPostRequest(data);
    result.fold(
      (error) {
        emit(AuthError(error)); // Handle error case
      },
      (response) {
        if (response.statusCode == 200) {
          final responseData = response.data;

          if (responseData['success'] == true) {
            final accessToken = responseData['token'];
            final refreshToken = responseData['refresh_token'];

            prefs?.setString('accessToken', accessToken);
            prefs?.setString('refreshToken', refreshToken);

            log('Access Token: $accessToken');
            log('Refresh Token: $refreshToken');

            emit(AuthAuthenticated());
          } else {
            // Handle unsuccessful sign-in
            final errorMessage = responseData['msg'];
            emit(AuthError(errorMessage));
          }
        }
      },
    );
  }

  // Method to sign out the user
  Future<void> signOut() async {
    emit(AuthLoading()); // Emit loading state

    final result = await apiServices.userLogoutPostRequest(prefs!);
    result.fold(
      (error) {
        emit(AuthError(error)); // Handle error case
      },
      (_) {
        emit(AuthInitial()); // Logout successful, revert to initial state
      },
    );
  }

  // // Method to sign out the user
  // Future<void> signOut() async {
  //   // Perform sign out logic (e.g., clear session, etc.)
  //   // Emit AuthInitial to indicate that the user is signed out
  //   emit(AuthInitial());
  // }
}
