import 'package:flutter/material.dart';

import '../../app_colors.dart';

class BorderButton extends StatelessWidget {
  const BorderButton({
    super.key,
    required this.title,
    required this.active,
    required this.onPressed,
  });

  final String title;
  final bool active;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: active ? onPressed : null,
        borderRadius: BorderRadius.circular(8),
        splashColor: Colors.yellow[600],
        splashFactory: InkRipple.splashFactory,
        child: Ink(
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: active ? AppColors.primaryOrange : AppColors.basicWhite2,
              width: 2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  color: active ? AppColors.primaryBlack : AppColors.basicGrey4,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
