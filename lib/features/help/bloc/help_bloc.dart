import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils.dart';
import '../help_repository.dart';

part 'help_event.dart';
part 'help_state.dart';

class HelpBloc extends Bloc<HelpEvent, HelpState> {
  final _repository = HelpRepository();

  HelpBloc() : super(HelpInitial()) {
    on<CheckEvent>((event, emit) {
      emit(HelpInitial());
    });

    on<HelpButtonEvent>((event, emit) async {
      emit(HelpLoadingState());

      await Future.delayed(const Duration(seconds: 1));

      String phone = Utils.formatPhone(event.phone);

      bool result = await _repository.help(
        event.name,
        phone,
        event.email,
      );

      Utils.nameValid = false;
      Utils.emailValid = false;
      Utils.txtValid = false;

      if (result) {
        emit(HelpSuccessState());
      } else {
        emit(HelpErrorState());
      }
    });
  }
}
