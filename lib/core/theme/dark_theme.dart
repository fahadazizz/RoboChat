import 'package:flutter/material.dart';
import 'package:ai_buddy_chatbot/core/constant/app_colors.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.backgroundDark,
  fontFamily: 'Poppins',
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.backgroundDark,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
);
