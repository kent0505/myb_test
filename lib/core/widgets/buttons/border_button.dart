import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/app_colors.dart';

class BorderButton extends StatelessWidget {
  const BorderButton({
    super.key,
    required this.title,
    required this.active,
    this.icon = '',
    this.onPressed,
  });

  final String title;
  final bool active;
  final String icon;
  final Function()? onPressed;

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
              icon.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: SvgPicture.asset(
                        'assets/icons/$icon.svg',
                        width: 18,
                        height: 18,
                      ),
                    )
                  : Container(),
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  color: active || icon.isNotEmpty
                      ? AppColors.primaryBlack
                      : AppColors.basicGrey4,
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
