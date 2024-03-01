import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app_colors.dart';
import '../../buttons/yellow_button.dart';

class ErrorDialogWidget extends StatelessWidget {
  const ErrorDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 342,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Spacer(),
          const Text(
            'Произошла ошибка!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryText,
            ),
          ),
          const Spacer(),
          YellowButton(
            title: 'В главное меню',
            active: true,
            onPressed: () {
              context.pop();
              // deactivateSwitches();
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
