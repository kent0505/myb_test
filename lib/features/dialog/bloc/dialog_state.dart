part of 'dialog_bloc.dart';

abstract class DialogState {}

class DialogInitial extends DialogState {}

class DialogLoadingState extends DialogState {}

class DialogSuccessState extends DialogState {}

class DialogErrorState extends DialogState {}
