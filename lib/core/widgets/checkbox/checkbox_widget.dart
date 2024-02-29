import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app_colors.dart';

class CheckboxWidget extends StatefulWidget {
  const CheckboxWidget({
    super.key,
    required this.title,
    required this.checked,
    this.onTap,
  });

  final String title;
  final bool checked;
  final void Function()? onTap;

  @override
  State<CheckboxWidget> createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  // bool checked = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () {
      //   setState(() {
      //     checked = !checked;
      //   });
      // },
      splashColor: Colors.transparent,
      onTap: widget.onTap,
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
                color: widget.checked
                    ? AppColors.primaryOrange
                    : const Color(0xffDEE6EF),
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.all(3),
              child: widget.checked
                  ? SvgPicture.asset('assets/icons/check.svg')
                  : Container(),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                widget.title,
                style: TextStyle(
                  color: widget.checked
                      ? AppColors.primaryBlack
                      : AppColors.basicGrey1,
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
