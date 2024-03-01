part of 'dialog_bloc.dart';

abstract class DialogEvent {}

class ListenEvent extends DialogEvent {}

class ChangeStateEvent extends DialogEvent {}

class AddButtonEvent extends DialogEvent {
  final String phone;
  final List<int> categories;
  final String comment;
  AddButtonEvent(
    this.phone,
    this.categories,
    this.comment,
  );
}

class DeleteButtonEvent extends DialogEvent {}
