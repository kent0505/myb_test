part of 'menu_bloc.dart';

abstract class MenuEvent {}

class GetCategoriesEvent extends MenuEvent {}

class BlockAllNumbers extends MenuEvent {}

class BlockMydbNumbers extends MenuEvent {}

class BlockCategory extends MenuEvent {
  final int id;
  BlockCategory(this.id);
}
