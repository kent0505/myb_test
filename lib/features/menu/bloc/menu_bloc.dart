import 'package:flutter_bloc/flutter_bloc.dart';

import '../menu_repository.dart';
import '../models/category.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final _repository = MenuRepository();

  MenuBloc() : super(MenuInitial()) {
    on<GetCategoriesEvent>((event, emit) async {
      emit(MenuLoadingState());

      Result result = await _repository.fetchCategories();

      if (result is CategoriesResult) {
        emit(MenuLoadedState(result.categories));
      } else {
        emit(MenuLoadedState([]));
      }
    });
  }
}
