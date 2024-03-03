import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils.dart';
import '../dialog_repository.dart';

part 'dialog_event.dart';
part 'dialog_state.dart';

class DialogBloc extends Bloc<DialogEvent, DialogState> {
  final _repository = DialogRepository();
  String? phone;

  DialogBloc() : super(DialogInitial()) {
    on<ListenEvent>((event, emit) {
      emit(DialogInitial());
    });

    on<ChangeStateEvent>((event, emit) {
      for (var category in Utils.categories) {
        if (category.checked) {
          category.checked = false;
        }
      }
      emit(DialogInitial());
    });

    on<CheckboxEvent>((event, emit) {
      Utils.categories[event.index].checked =
          !Utils.categories[event.index].checked;
      Utils.cid = [];
      for (var category in Utils.categories) {
        if (category.checked) {
          Utils.cid.add(category.id);
        }
      }
      emit(DialogInitial());
    });

    on<AddButtonEvent>((event, emit) async {
      emit(DialogLoadingState());

      phone = Utils.formatPhone(event.phone);

      if (event.add) {
        Result result = await _repository.addBlacklist(
          phone!,
          event.cid,
          event.comment,
        );
        if (result is SuccessResult) {
          emit(DialogSuccessState());
        } else {
          emit(DialogErrorState());
        }
      } else {
        Result result = await _repository.updateBlacklist(
          phone!,
          event.cid,
          event.comment,
        );
        if (result is SuccessResult) {
          emit(DialogSuccessState());
        } else {
          emit(DialogErrorState());
        }
      }
    });

    on<DeleteButtonEvent>((event, emit) async {
      emit(DialogLoadingState());

      List<String> phones = [];

      for (var phone in Utils.blacklist) {
        if (phone.checked) {
          phones.add(phone.phone);
        }
      }

      Result result = await _repository.deleteBlacklist(phones);

      if (result is SuccessResult) {
        emit(DialogSuccessState());
      } else {
        emit(DialogErrorState());
      }
    });
  }
}
