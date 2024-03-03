import 'package:flutter/material.dart';

import '../../../config/app_colors.dart';

class LabelText extends StatelessWidget {
  const LabelText({
    super.key,
    required this.label,
    this.star = false,
  });

  final String label;
  final bool star;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.basicGrey4,
          ),
        ),
        Text(
          star ? ' *' : '',
          style: const TextStyle(
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
