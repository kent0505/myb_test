import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  Timer? _timer;
  int seconds = 21;

  TimerBloc() : super(TimerInitial()) {
    on<StartTimerEvent>((event, emit) {
      seconds = 21;
      add(DecrementEvent());
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        add(DecrementEvent());
        print('Second = $seconds');
      });
    });

    on<StopTimerEvent>((event, emit) {
      _timer!.cancel();
      emit(TimerStoppedState());
    });

    on<DecrementEvent>((event, emit) {
      if (seconds == 1) {
        _timer!.cancel();
        emit(TimerStoppedState());
      } else {
        seconds--;
        emit(TimerStartedState());
      }
    });
  }
}
