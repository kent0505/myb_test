import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils.dart';
import '../check_repository.dart';

part 'check_event.dart';
part 'check_state.dart';

class CheckBloc extends Bloc<CheckEvent, CheckState> {
  final _repository = CheckRepository();

  String? phone;
  int? blocked;
  String? operator;
  String? region;

  CheckBloc() : super(CheckInitial()) {
    on<ListenEvent>((event, emit) {
      if (state is CheckResultState) {
        emit(CheckResultState(
          phone!,
          blocked!,
          operator!,
          region!,
        ));
      } else {
        emit(CheckInitial());
      }
    });

    on<CheckButtonEvent>((event, emit) async {
      phone = event.phone;

      Utils.phoneValid = false;

      emit(CheckLoadingState());

      CheckResult result = await _repository.getPhoneInfo(
        event.phone
            .replaceAll('+', '')
            .replaceAll(' (', '')
            .replaceAll(') ', '')
            .replaceAll('-', ''),
      );

      Utils.phoneValid = false;

      if (result is CheckSuccessResult) {
        blocked = result.blocked;
        operator = result.operator;
        region = result.region;

        emit(CheckResultState(
          phone ?? '',
          blocked ?? 0,
          operator ?? '',
          region ?? '',
        ));
      } else {
        emit(CheckInitial());
      }
    });
  }
}
