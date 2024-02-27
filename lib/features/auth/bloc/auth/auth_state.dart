part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class PhoneState extends AuthState {}

class OtpState extends AuthState {}

class ReasonState extends AuthState {}

class OnboardingState extends AuthState {}

class HomeState extends AuthState {}
