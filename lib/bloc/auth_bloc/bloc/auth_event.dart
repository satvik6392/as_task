part of 'auth_bloc.dart';

// @immutable
sealed class AuthEvent {}

class LoginEvent extends AuthEvent{
  String email;
  String password;
  LoginEvent({required this.email,required this.password});
}
class SignUpEvent extends AuthEvent{
  String email;
  String password;
  SignUpEvent({required this.email,required this.password});
}
class PasswordResetEvent extends AuthEvent{
  String email;
  PasswordResetEvent({required this.email});
}
