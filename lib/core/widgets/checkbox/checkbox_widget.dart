import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/app_colors.dart';

class CheckboxWidget extends StatelessWidget {
  const CheckboxWidget(
    this.title, {
    super.key,
    required this.checked,
    this.onTap,
  });

  final String title;
  final bool checked;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 9),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color:
                    checked ? AppColors.primaryOrange : const Color(0xffDEE6EF),
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.all(3),
              child: checked
                  ? SvgPicture.asset('assets/icons/check.svg')
                  : Container(),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color:
                      checked ? AppColors.primaryBlack : AppColors.basicGrey1,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
