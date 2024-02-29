part of 'check_bloc.dart';

abstract class CheckEvent {}

class ListenEvent extends CheckEvent {}

class CheckButtonEvent extends CheckEvent {
  final String phone;
  CheckButtonEvent(this.phone);
}

class AddToBlacklistEvent extends CheckEvent {
  final String phone;
  final List<int> categories;
  final String comment;
  AddToBlacklistEvent(
    this.phone,
    this.categories,
    this.comment,
  );
}
