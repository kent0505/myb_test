part of 'auth_bloc.dart';

abstract class AuthEvent {}

class LoginInitialEvent extends AuthEvent {}

class CheckEvent extends AuthEvent {}

class LoginEvent extends AuthEvent {
  final String phone;
  LoginEvent(this.phone);
}

class CheckOtpEvent extends AuthEvent {
  final String otp;
  CheckOtpEvent(this.otp);
}

class ReasonEvent extends AuthEvent {
  final bool first;
  ReasonEvent(this.first);
}
