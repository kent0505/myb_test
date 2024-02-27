import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app_colors.dart';
import '../../../core/widgets/buttons/yellow_button.dart';
import '../bloc/help_bloc.dart';

class HelpSuccessWidget extends StatelessWidget {
  const HelpSuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Благодарим за доверие!',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 25,
          ),
        ),
        const SizedBox(height: 30),
        const Text(
          'В ближайшее время с вами свяжется юрист для уточнения деталей Вашей ситуации.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Пожалуйста, ответьте на входящий звонок.',
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
            context.read<HelpBloc>().add(BackButtonEvent());
          },
        ),
      ],
    );
  }
}
