part of 'mydb_bloc.dart';

abstract class MydbEvent {}

class GetBlacklistEvent extends MydbEvent {}

class CheckActiveEvent extends MydbEvent {}

class CheckboxEvent extends MydbEvent {
  final int index;
  CheckboxEvent(this.index);
}

class DeletePhoneEvent extends MydbEvent {}
