import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/buttons/yellow_button.dart';
import '../bloc/settings_bloc.dart';

class AppealErrorWidget extends StatelessWidget {
  const AppealErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 21),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Произошла ошибка, повторите чуть позже',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 25,
            ),
          ),
          const SizedBox(height: 40),
          YellowButton(
            title: 'В главное меню',
            active: true,
            onPressed: () {
              context.read<SettingsBloc>().add(BackButtonEvent());
            },
          ),
        ],
      ),
    );
  }
}
