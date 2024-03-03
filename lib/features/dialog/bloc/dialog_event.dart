part of 'dialog_bloc.dart';

abstract class DialogEvent {}

class ListenEvent extends DialogEvent {}

class ChangeStateEvent extends DialogEvent {}

class CheckboxEvent extends DialogEvent {
  final int index;
  CheckboxEvent(this.index);
}

class AddButtonEvent extends DialogEvent {
  final bool add;
  final String phone;
  final List<int> cid;
  final String comment;
  AddButtonEvent(
    this.add,
    this.phone,
    this.cid,
    this.comment,
  );
}

class DeleteButtonEvent extends DialogEvent {}
