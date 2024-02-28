import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myb_test/features/mydb/models/phone.dart';

import '../mydb_repository.dart';

part 'mydb_event.dart';
part 'mydb_state.dart';

class MydbBloc extends Bloc<MydbEvent, MydbState> {
  final _repository = MydbRepository();

  MydbBloc() : super(MydbInitial()) {
    on<GetBlacklistEvent>((event, emit) async {
      emit(MydbLodingState());

      Result result = await _repository.fetchPhones();

      if (result is PhonesResult) {
        emit(MydbLoaded(result.blacklist));
      } else {
        emit(MydbLoaded([]));
      }
    });
  }
}
