import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/config/app_colors.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 74),
        SizedBox(
          height: 104,
          child: SvgPicture.asset(
            'assets/images/logo.svg',
            height: 100,
          ),
        ),
        const SizedBox(height: 53),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'МЮБ ',
              style: TextStyle(
                color: AppColors.primaryText,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                height: 0.06,
                letterSpacing: -0.60,
              ),
            ),
            Text(
              'Спам-защитник',
              style: TextStyle(
                color: AppColors.primaryText,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                height: 0.06,
                letterSpacing: -0.60,
              ),
            ),
          ],
        )
      ],
    );
  }
}
