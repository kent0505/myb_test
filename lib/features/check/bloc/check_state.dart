part of 'check_bloc.dart';

abstract class CheckState {}

class CheckInitial extends CheckState {}

class CheckLoadingState extends CheckState {}

class AddedState extends CheckState {}

class ErrorState extends CheckState {}

class CheckResultState extends CheckState {
  final String phone;
  final String operator;
  final String region;
  final List<int> categories;
  CheckResultState(
    this.phone,
    this.operator,
    this.region,
    this.categories,
  );
}

class CheckResultErrorState extends CheckState {
  final String phone;
  CheckResultErrorState(
    this.phone,
  );
}
