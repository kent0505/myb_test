import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils.dart';
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
        Utils.categories = result.categories;
        emit(MenuLoadedState(Utils.categories));
      } else {
        emit(MenuLoadedState([]));
      }
    });

    on<BlockAllNumbers>((event, emit) {
      if (Utils.allNumbers) {
        Utils.allNumbers = false;
      } else {
        Utils.allNumbers = true;
        Utils.mydbNumbers = false;
      }

      emit(MenuLoadedState(Utils.categories));
    });

    on<BlockMydbNumbers>((event, emit) {
      if (Utils.mydbNumbers) {
        Utils.mydbNumbers = false;
      } else {
        Utils.mydbNumbers = true;
        Utils.allNumbers = false;
      }

      emit(MenuLoadedState(Utils.categories));
    });

    on<BlockCategory>((event, emit) {
      Utils.categoriesToBlock = Utils.categories;

      for (var category in Utils.categoriesToBlock) {
        if (category.id == event.id) {
          category.checked = !category.checked;
        }
      }
      emit(MenuLoadedState(Utils.categories));
    });
  }
}
