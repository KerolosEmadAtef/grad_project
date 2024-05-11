import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'auth_state.dart';
import 'package:test1/data/web_services/auth_service.dart'; // Import your authentication service
import 'package:test1/data/models/auth_models.dart'; // Import your authentication models

class AuthCubit extends Cubit<AuthState> {
  final ApiServices apiServices;

  AuthCubit({required this.apiServices}) : super(AuthInitial());

  // Method to sign in the user
  Future<void> signIn(LoginModel data) async {
    emit(AuthLoading()); // Emit loading state

    try {
      // Perform authentication logic (e.g., API request)
      // final signInResponse = await apiServices.signinPostRequest(data);
      // final response = signInResponse.response;
      // final statusCode = response.statusCode;

      final response = await apiServices.signinPostRequest(data) ?? "";
      log('+++++++++++++++++++++++++++++++++++++++++');

      log('Response status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        log('Sign-in successful');
        final userName = response.data['name'];
        // Authentication successful, emit AuthAuthenticated state
        emit(AuthAuthenticated());
      } else {
        log('Sign-in failed with message: ${response.data['msg']}');
        // Authentication failed, emit AuthError with error message
        emit(AuthError(response.data['msg']));
      }
    } catch (e) {
      // emit(AuthError('An error occurred. Please try again later.'));
      log('Exception occurred during sign-in: $e');

      // ignore: deprecated_member_use
      if (e is DioError && e.response != null) {
        // Request failed with a non-200 status code
        final errorMessage = e.response!.data['msg'] ??
            'An error occurred. Please try again later.';
        emit(AuthError(errorMessage));
      } else {
        // Other error occurred (e.g., network error)
        emit(AuthError('An error occurred. Please try again later.'));
        // }
      }
    }
    // Method to sign out the user
    Future<void> signOut() async {
      // Perform sign out logic (e.g., clear session, etc.)
      // Emit AuthInitial to indicate that the user is signed out
      emit(AuthInitial());
    }
  }
}
