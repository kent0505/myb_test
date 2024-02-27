import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app_colors.dart';

class YellowButton extends StatelessWidget {
  const YellowButton({
    super.key,
    this.onPressed,
    required this.title,
    required this.active,
    this.icon = '',
  });

  final Function()? onPressed;
  final String title;
  final bool active;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Material(
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: active ? onPressed : null,
          borderRadius: BorderRadius.circular(8),
          splashColor: Colors.yellow[600],
          child: Ink(
            height: 44,
            decoration: BoxDecoration(
              color: active ? AppColors.primaryOrange : AppColors.basicWhite2,
              borderRadius: BorderRadius.circular(8),
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
                    color:
                        active ? AppColors.primaryBlack : AppColors.basicGrey4,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Center(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     if (type == 3) ...[
//                       SvgPicture.asset(
//                         'assets/icons/global_search.svg',
//                         width: 18,
//                         height: 18,
//                       ),
//                       const SizedBox(width: 8),
//                     ],
//                     Text(
//                       title,
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: type == 2
//                             ? const Color(0xff94a3b8)
//                             : AppColors.primaryBlack,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),



// if (type == 0) ...[
//                 Ink(
//                   height: 44,
//                   decoration: BoxDecoration(
//                     color: const Color(0xffffda0c),
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(
//                       color: const Color(0xffffda0c),
//                     ),
//                   ),
//                 ),
//               ] else if (type == 1) ...[
//                 Ink(
//                   height: 44,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(
//                       color: const Color(0xffffda0c),
//                       width: 2,
//                     ),
//                   ),
//                 ),
//               ] else if (type == 2) ...[
//                 Ink(
//                   height: 44,
//                   decoration: BoxDecoration(
//                     color: const Color(0xffdee6ef),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//               ] else if (type == 3) ...[
//                 Ink(
//                   height: 44,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(
//                       color: const Color(0xffdee6ef),
//                       width: 2,
//                     ),
//                   ),
//                 ),
//               ],