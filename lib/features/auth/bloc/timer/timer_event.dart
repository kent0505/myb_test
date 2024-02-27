part of 'timer_bloc.dart';

abstract class TimerEvent {}

class StartTimerEvent extends TimerEvent {}

class StopTimerEvent extends TimerEvent {}

class DecrementEvent extends TimerEvent {}
