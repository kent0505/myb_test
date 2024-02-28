part of 'mydb_bloc.dart';

abstract class MydbState {}

class MydbInitial extends MydbState {}

class MydbLodingState extends MydbState {}

class MydbLoaded extends MydbState {
  final List<Phone> blacklist;
  MydbLoaded(this.blacklist);
}
