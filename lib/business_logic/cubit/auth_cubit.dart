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

            emit(AuthAuthenticated());
          } else {
            // Handle unsuccessful sign-in
            final errorMessage = responseData['msg'];
            emit(AuthError(errorMessage));
          }
        }
      },
    );
    // try {
    //   final response = await apiServices.signinPostRequest(data);
    //   if (response.statusCode == 200) {
    //     final responseData = response.data;

    //     if (responseData['success'] ?? true) {
    //       emit(AuthAuthenticated());

    //       final accessToken = responseData['token'];
    //       final refreshToken = responseData['refresh_token'];

    //       prefs?.setString('accessToken', accessToken);
    //       prefs?.setString('refreshToken', refreshToken);
    //     } else if (response.statusCode == 401) {
    //       final errorMessage = responseData['msg'];
    //       emit(AuthError(errorMessage));
    //     } else {
    //       // final errorMessage = responseData['msg'];
    //       emit(AuthError('An error occurred. Please try again later.'));
    //     }
    //   }
    // } catch (e) {
    //   rethrow;
    // }
    // Perform authentication logic (e.g., API request)
    // final signInResponse = await apiServices.signinPostRequest(data);
    // final response = signInResponse.response;
    // final statusCode = response.statusCode;
    // final response = await apiServices.signinPostRequest(data);
    // log('Response status code: ${response.statusCode}');
    // if (response.statusCode == 200) {
    //   log('Sign-in successful');
    //   final userName = response.data['name'];
    //   // Authentication successful, emit AuthAuthenticated state
    //   emit(AuthAuthenticated(userName));
    // } else {
    //   log('Sign-in failed with message: ${response.data['msg']}');
    //   // Authentication failed, emit AuthError with error message
    //   emit(AuthError(response.data['msg']));
    // }

    // emit(AuthError('An error occurred. Please try again later.'));
    // log('Exception occurred during sign-in: $e');

    // // ignore: deprecated_member_use
    // if (e is DioError && e.response != null) {
    //   // Request failed with a non-200 status code
    //   final errorMessage = e.response!.data['msg'] ??
    //       'An error occurred. Please try again later.';
    //   emit(AuthError(errorMessage));
    // } else {
    //   // Other error occurred (e.g., network error)
    //   emit(AuthError('An error occurred. Please try again later.'));
    //   // }
    // }
  }

  // Method to sign out the user
  Future<void> signOut() async {
    // Perform sign out logic (e.g., clear session, etc.)
    // Emit AuthInitial to indicate that the user is signed out
    emit(AuthInitial());
  }
}
