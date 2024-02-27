import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app_colors.dart';
import '../../../core/widgets/buttons/yellow_button.dart';
import '../bloc/settings_bloc.dart';

class AppealSuccessWidget extends StatelessWidget {
  const AppealSuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 21),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Благодарим за обращение!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'Мы ценим каждое обращение. Вы помогаете нам стать лучше и эффективнее.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.primaryBlack,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Спасибо!',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.basicGrey1,
            ),
          ),
          const SizedBox(height: 40),
          YellowButton(
            title: 'В главное меню',
            active: true,
            onPressed: () {
              context.read<SettingsBloc>().add(BackButtonEvent());
            },
          )
        ],
      ),
    );
  }
}
