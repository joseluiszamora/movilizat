part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String userId;
  final String email;

  const AuthAuthenticated({required this.userId, required this.email});

  @override
  List<Object> get props => [userId, email];
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String error;

  const AuthError(this.error);

  @override
  List<Object> get props => [error];
}
