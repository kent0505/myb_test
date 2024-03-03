import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../config/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
      title: const Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'МЮБ ',
              style: TextStyle(
                color: AppColors.primaryText,
                fontWeight: FontWeight.w700,
                fontSize: 20,
                letterSpacing: -1.5,
              ),
            ),
            TextSpan(
              text: 'Спам-защитник',
              style: TextStyle(
                color: AppColors.primaryText,
                fontWeight: FontWeight.w500,
                fontSize: 20,
                letterSpacing: -1.5,
              ),
            ),
          ],
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
