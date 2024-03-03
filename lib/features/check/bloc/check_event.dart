part of 'check_bloc.dart';

abstract class CheckEvent {}

class ListenEvent extends CheckEvent {}

class CheckButtonEvent extends CheckEvent {
  final String phone;
  CheckButtonEvent(this.phone);
}
