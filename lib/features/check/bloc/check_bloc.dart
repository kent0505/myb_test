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
  List<int>? categories;

  CheckBloc() : super(CheckInitial()) {
    on<ListenEvent>((event, emit) {
      if (state is CheckResultState) {
        emit(CheckResultState(
          phone!,
          blocked!,
          operator!,
          region!,
          categories!,
        ));
      } else {
        emit(CheckInitial());
      }
    });

    on<CheckButtonEvent>((event, emit) async {
      phone = event.phone;

      Utils.phoneValid = false;

      emit(CheckLoadingState());

      String formattedPhone = Utils.formatPhone(event.phone);

      print(formattedPhone);

      Result result1 = await _repository.getPhoneInfo(
        formattedPhone.replaceAll('+', ''),
      );
      Result result2 = await _repository.getPhoneFromBlacklist(formattedPhone);

      if (result1 is SuccessResult && result2 is GetResult) {
        blocked = result1.blocked;
        operator = result1.operator;
        region = result1.region;
        categories = result2.categories;

        emit(CheckResultState(
          phone ?? '',
          blocked ?? 0,
          operator ?? '',
          region ?? '',
          categories ?? [],
        ));
      } else {
        emit(CheckInitial());
      }
    });

    on<AddToBlacklistEvent>((event, emit) async {
      emit(CheckLoadingState());

      phone = Utils.formatPhone(event.phone);

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
