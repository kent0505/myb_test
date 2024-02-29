part of 'check_bloc.dart';

abstract class CheckState {}

class CheckInitial extends CheckState {}

class CheckLoadingState extends CheckState {}

class AddedState extends CheckState {}

class ErrorState extends CheckState {}

class CheckResultState extends CheckState {
  final String phone;
  final int blocked;
  final String operator;
  final String region;
  CheckResultState(
    this.phone,
    this.blocked,
    this.operator,
    this.region,
  );
}

class CheckResultErrorState extends CheckState {
  final String phone;
  CheckResultErrorState(
    this.phone,
  );
}
