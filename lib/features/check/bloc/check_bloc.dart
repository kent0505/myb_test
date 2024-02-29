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

      Result result = await _repository.getPhoneInfo(
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

    on<AddToBlacklistEvent>((event, emit) async {
      emit(CheckLoadingState());

      phone = event.phone
          .replaceAll(' (', '')
          .replaceAll(') ', '')
          .replaceAll('-', '');

      print(phone);
      print(event.categories);
      print(event.comment);
      // await Future.delayed(const Duration(seconds: 2));

      // emit(ErrorState());

      // await Future.delayed(const Duration(seconds: 2));

      // emit(AddedState());

      Result result = await _repository.addToBlacklist(
        phone!,
        event.categories,
        event.comment,
      );

      if (result is AddedResult) {
        emit(AddedState());
      } else {
        emit(ErrorState());
      }
    });
  }
}
