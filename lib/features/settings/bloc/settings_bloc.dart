import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils.dart';
import '../settings_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final _repository = SettingsRepository();

  SettingsBloc() : super(SettingsInitial()) {
    on<SwitchEvent>((event, emit) {
      // логика включения режима блокировки или предупреждения
      if (event.warn) {
        if (Utils.block) {
          Utils.block = false;
        }
        Utils.warn = !Utils.warn;
      } else {
        if (Utils.warn) {
          Utils.warn = false;
        }
        Utils.block = !Utils.block;
      }
      Utils.saveBool('warn', Utils.warn);
      Utils.saveBool('block', Utils.block);
      emit(SettingsInitial());
    });

    on<SubmitButtonEvent>((event, emit) async {
      emit(SettingsLoadingState());
      await Future.delayed(const Duration(seconds: 1));
      final result = await _repository.appeal(
        event.name,
        event.email,
        event.message,
      );
      if (result) {
        emit(SettingsSuccessState());
      } else {
        emit(SettingsErrorState());
      }
    });

    on<AppealButtonEvent>((event, emit) {
      emit(SettingsAppealState());
    });

    on<BackButtonEvent>((event, emit) {
      Utils.nameValid = false;
      Utils.emailValid = false;
      Utils.txtValid = false;
      emit(SettingsInitial());
    });
  }
}
