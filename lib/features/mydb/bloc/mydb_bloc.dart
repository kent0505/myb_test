import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils.dart';
import '../models/phone.dart';
import '../mydb_repository.dart';

part 'mydb_event.dart';
part 'mydb_state.dart';

class MydbBloc extends Bloc<MydbEvent, MydbState> {
  final _repository = MydbRepository();

  MydbBloc() : super(MydbInitial()) {
    on<GetBlacklistEvent>((event, emit) async {
      emit(MydbLodingState());

      Result result = await _repository.fetchPhones();

      if (result is BlacklistResult) {
        Utils.blacklist = result.blacklist;
        emit(MydbLoaded(result.blacklist));
      } else {
        emit(MydbLoaded([]));
      }
    });

    on<CheckActiveEvent>((event, emit) async {
      emit(MydbLoaded(Utils.blacklist));
    });

    on<CheckboxEvent>((event, emit) {
      Utils.blacklist[event.index].checked =
          !Utils.blacklist[event.index].checked;

      emit(MydbLoaded(Utils.blacklist));
    });

    on<DeletePhoneEvent>((event, emit) async {
      List<String> phones = [];

      for (var phone in Utils.blacklist) {
        if (phone.checked) {
          phones.add(phone.phone);
        }
      }

      emit(MydbLodingState());

      await Future.delayed(const Duration(seconds: 2));

      Result result = await _repository.deletePhones(phones);

      if (result is SuccessResult) {
        add(GetBlacklistEvent());
      } else {
        emit(MydbLoaded(Utils.blacklist));
      }
    });
  }
}
