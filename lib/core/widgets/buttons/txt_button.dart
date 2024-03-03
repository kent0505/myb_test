import 'package:flutter/material.dart';

import '../../config/app_colors.dart';

class TxtButton extends StatelessWidget {
  const TxtButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashFactory: InkRipple.splashFactory,
      radius: 400,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 2,
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: AppColors.basicGrey4,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
