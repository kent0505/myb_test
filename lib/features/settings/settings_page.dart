import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/settings_bloc.dart';
import 'widgets/appeal_error_widget.dart';
import 'widgets/appeal_widget.dart';
import 'widgets/appeal_success_widget.dart';
import 'widgets/settings_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state is SettingsInitial) {
          return const SettingsWidget();
        }

        if (state is SettingsAppealState) {
          return const AppealWidget();
        }

        if (state is SettingsSuccessState) {
          return const AppealSuccessWidget();
        }

        if (state is SettingsErrorState) {
          return const AppealErrorWidget();
        }

        return Container();
      },
    );
  }
}
