import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/buttons/yellow_button.dart';
import '../bloc/help_bloc.dart';

class HelpErrorWidget extends StatelessWidget {
  const HelpErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
            context.read<HelpBloc>().add(BackButtonEvent());
          },
        ),
      ],
    );
  }
}
