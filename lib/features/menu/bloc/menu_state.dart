part of 'menu_bloc.dart';

abstract class MenuState {}

class MenuInitial extends MenuState {}

class MenuLoadingState extends MenuState {}

class MenuLoadedState extends MenuState {
  final List<Category> categories;
  MenuLoadedState(this.categories);
}
