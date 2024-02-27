part of 'help_bloc.dart';

abstract class HelpEvent {}

class ListenEvent extends HelpEvent {}

class HelpButtonEvent extends HelpEvent {
  final String name;
  final String phone;
  final String email;
  HelpButtonEvent(
    this.name,
    this.phone,
    this.email,
  );
}

class BackButtonEvent extends HelpEvent {}
