import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/config/app_colors.dart';
import '../models/page_model.dart';

class PageWidget extends StatelessWidget {
  const PageWidget({
    super.key,
    required this.pageModel,
  });

  final PageModel pageModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 66),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            pageModel.iconPath,
            height: 77,
          ),
          const SizedBox(height: 30),
          Text(
            pageModel.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.primaryBlack,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 30),
          Text(
            pageModel.subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.basicGrey1,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
