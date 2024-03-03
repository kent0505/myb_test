import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/widgets/buttons/yellow_button.dart';
import '../../../core/widgets/text/text_widget.dart';

class MenuPageDialog extends StatelessWidget {
  const MenuPageDialog({super.key});

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
              const TextWidget(
                'При нажатии на кнопку "Обновить базу", база нежелательных номеров обновляется принудительно',
                size: 14,
                weight: 500,
                center: true,
                color: AppColors.primaryBlack,
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
