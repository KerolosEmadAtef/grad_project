abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class StopLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  AuthAuthenticated(userName);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
