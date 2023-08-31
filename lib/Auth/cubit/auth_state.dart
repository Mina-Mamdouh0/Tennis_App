part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {}

class AuthErrorState extends AuthState {
  final String error;

  AuthErrorState(this.error);
}

class GooglLoadingState extends AuthState {}

class GooglSuccessState extends AuthState {}

class GooglErrorState extends AuthState {
  final String error;

  GooglErrorState(this.error);
}
