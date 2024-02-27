import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myb_test/features/check/check_repository.dart';

import '../../../core/utils.dart';

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

      if (state is CheckInitial) {
        emit(CheckLoadingState());
      } else {
        emit(CheckResultLoadingState());
      }

      CheckResult result = await _repository.getPhoneInfo(
        event.phone
            .replaceAll('+', '')
            .replaceAll(' (', '')
            .replaceAll(') ', '')
            .replaceAll('-', ''),
      );

      if (result is CheckSuccessResult) {
        blocked = result.blocked;
        operator = result.operator;
        region = result.region;

        emit(CheckResultState(
          phone!,
          blocked!,
          operator!,
          region!,
        ));
      } else {
        emit(CheckInitial());
      }

      Utils.phoneValid = false;
    });
  }
}
