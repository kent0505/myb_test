import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/app_colors.dart';

class AdditionalButton extends StatelessWidget {
  const AdditionalButton({
    super.key,
    required this.title,
    required this.asset,
    this.blue = false,
    required this.onTap,
  });

  final String title;
  final String asset;
  final bool blue;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        asset.isNotEmpty
            ? SvgPicture.asset(
                'assets/icons/$asset.svg',
                height: 18,
                width: 18,
              )
            : const SizedBox(
                height: 18,
                width: 18,
              ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: onTap,
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              shadows: [
                Shadow(
                  color: blue ? AppColors.brandSky : AppColors.primaryBlack,
                  offset: const Offset(0, -1.5),
                )
              ],
              color: Colors.transparent,
              decoration: TextDecoration.underline,
              decorationColor:
                  blue ? AppColors.brandSky : AppColors.primaryBlack,
              decorationThickness: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
