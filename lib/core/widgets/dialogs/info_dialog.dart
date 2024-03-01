import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app_colors.dart';
import '../buttons/yellow_button.dart';

class InfoDialog extends StatelessWidget {
  const InfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: SizedBox(
          height: 342,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacer(),
              const Text(
                'Обновляет базу',
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
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
