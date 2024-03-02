import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryOrange = Color(0xffFFDA0C);
  static const Color primaryText = Color(0xff0F0F0F);
  static const Color primaryBlack = Color(0xff141414);

  static const Color basicBlack1 = Color(0xff1E1F22);
  static const Color basicBlack2 = Color(0xff2B2D31);
  static const Color basicBlack3 = Color(0xff232428);
  static const Color basicGrey1 = Color(0xff5F6874);
  static const Color basicGrey3 = Color(0xff475569);
  static const Color basicGrey4 = Color(0xff94A3B8);
  static const Color basicGrey5 = Color(0xFFC0C8D3);
  static const Color basicWhite1 = Color(0xffF1F5F9);
  static const Color basicWhite2 = Color(0xffDEE6EF);

  static const Color brandRed = Color(0xffF4404C);
  static const Color brandBlue = Color(0xff3246FF);
  static const Color brandGreen = Color(0xff05FF00);
  static const Color brandPurple = Color(0xffEE02E4);
  static const Color brandSky = Color(0xff00B2FF);
  static const Color brandYellow = Color(0xffFFF500);

  static const Color statusRed = Color(0xffE11D48);
  static const Color statusBlue = Color(0xff5790FF);
  static const Color statusGreen = Color(0xff34A853);
  static const Color statusOrange = Color(0xffFB8D0F);
}

Color getColor(int id) {
  switch (id) {
    case 1:
      return const Color(0x1af4404c);
    case 2:
      return const Color(0x2aFB8D0F);
    case 3:
      return const Color(0x3300B2FF);
    case 4:
      return const Color(0x2aFB8D0F);
    case 5:
      return const Color(0x1af4404c);
    case 6:
      return const Color(0x3300B2FF);
    case 7:
      return const Color(0x1af4404c);
    default:
      return const Color(0x2aFB8D0F);
  }
}

Color getTextColor(int id) {
  switch (id) {
    case 1:
      return AppColors.brandRed;
    case 2:
      return AppColors.statusOrange;
    case 3:
      return AppColors.brandSky;
    case 4:
      return AppColors.statusOrange;
    case 5:
      return AppColors.brandRed;
    case 6:
      return AppColors.brandSky;
    case 7:
      return AppColors.brandRed;
    default:
      return AppColors.statusOrange;
  }
}
