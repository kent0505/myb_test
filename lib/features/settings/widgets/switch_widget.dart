import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';

class SwitchWidget extends StatelessWidget {
  const SwitchWidget({
    super.key,
    required this.onTap,
    required this.active,
  });

  final void Function() onTap;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 24,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: active ? AppColors.primaryOrange : AppColors.basicWhite1,
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            right: active ? 3 : 19,
            left: active ? 19 : 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 3,
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 18,
                width: 18,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: active ? Colors.white : AppColors.basicGrey5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
