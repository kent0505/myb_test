part of 'timer_bloc.dart';

abstract class TimerState {}

class TimerInitial extends TimerState {}

class TimerStartedState extends TimerState {}

class TimerStoppedState extends TimerState {}
