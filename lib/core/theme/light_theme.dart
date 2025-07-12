import 'package:flutter/material.dart';
import 'package:ai_buddy_chatbot/core/constant/app_colors.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.backgroundLight,
  fontFamily: 'Poppins',
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
);
