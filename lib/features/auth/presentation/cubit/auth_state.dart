part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final String userId;

  AuthSuccess({required this.userId});
}

final class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});
}
