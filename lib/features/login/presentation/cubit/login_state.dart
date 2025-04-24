part of 'login_cubit.dart';

@immutable
sealed class LoginCubitState {}

final class LoginCubitInitial extends LoginCubitState {}

final class LoginLoading extends LoginCubitState {}

final class LoginSuccess extends LoginCubitState {
  final AuthToken authToken;
  LoginSuccess({required this.authToken});
}

final class LoginError extends LoginCubitState {
  final String errorMessage;
  LoginError({required this.errorMessage});
}
final class CredentialsLoading extends LoginCubitState {}
final class CredentialsSuccess extends LoginCubitState {
  final bool rememberMe;
  final UserCredentials? userCredentials;
  CredentialsSuccess({required this.rememberMe, this.userCredentials});
}
