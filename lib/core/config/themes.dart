import 'package:flutter/material.dart';

import 'app_colors.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.blueGrey,
  useMaterial3: false,
  fontFamily: 'Roboto Condensed',
  scaffoldBackgroundColor: Colors.white,
  primaryColor: AppColors.primaryOrange,
  colorScheme: const ColorScheme.light(
    primary: AppColors.primaryOrange,
    background: Colors.white,
    surface: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: false,
    backgroundColor: Colors.white,
    foregroundColor: AppColors.primaryText,
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryText,
    ),
  ),
);
