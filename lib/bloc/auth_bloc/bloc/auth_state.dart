part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class LoginLoading extends AuthState{}
class LoginFailed extends AuthState{}
class LoginSuccess extends AuthState{}

class SendingResetMail extends AuthState{}
class SendFailed extends AuthState{}
class SentSuccess extends AuthState{}
