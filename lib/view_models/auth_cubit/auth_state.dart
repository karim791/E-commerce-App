part of 'auth_cubit.dart';

sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthDone extends AuthState {
  const AuthDone();
}

final class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
}

final class Loggingout extends AuthState {}

final class Loggedout extends AuthState {}

final class LogoutFailure extends AuthState {
  final String message;
  const LogoutFailure(this.message);
}

final class GoogleSigning extends AuthState {}

final class GoogleSigned extends AuthState {}

final class GoogleSignFailure extends AuthState {
  final String message;
  const GoogleSignFailure(this.message);
}
