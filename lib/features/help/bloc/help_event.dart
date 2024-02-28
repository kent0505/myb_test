part of 'help_bloc.dart';

abstract class HelpEvent {}

class CheckEvent extends HelpEvent {}

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
