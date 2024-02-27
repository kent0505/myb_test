part of 'settings_bloc.dart';

abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsAppealState extends SettingsState {}

class SettingsLoadingState extends SettingsState {}

class SettingsSuccessState extends SettingsState {}

class SettingsErrorState extends SettingsState {}
