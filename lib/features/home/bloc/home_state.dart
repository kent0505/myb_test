part of 'home_bloc.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {
  final int index;
  HomeInitial(this.index);
}
