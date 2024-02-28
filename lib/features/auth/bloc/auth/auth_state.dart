part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoadingState extends AuthState {}

class ErrorState extends AuthState {}

class OtpState extends AuthState {}

class OtpErrorState extends AuthState {}

class ReasonState extends AuthState {}

class HomeState extends AuthState {}

class BlockerSettingsState extends AuthState {}
