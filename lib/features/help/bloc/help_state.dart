part of 'help_bloc.dart';

abstract class HelpState {}

class HelpInitial extends HelpState {}

class HelpLoadingState extends HelpState {}

class HelpSuccessState extends HelpState {}

class HelpErrorState extends HelpState {}
