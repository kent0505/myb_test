part of 'settings_bloc.dart';

abstract class SettingsEvent {}

class SwitchEvent extends SettingsEvent {
  final bool warn;
  final bool block;
  SwitchEvent(
    this.warn,
    this.block,
  );
}

class SubmitButtonEvent extends SettingsEvent {
  final String name;
  final String email;
  final String message;
  SubmitButtonEvent(
    this.name,
    this.email,
    this.message,
  );
}

class CheckEvent extends SettingsEvent {}
