import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDarkMode') ?? false;
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final newTheme = state == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    await prefs.setBool('isDarkMode', newTheme == ThemeMode.dark);
    emit(newTheme);
  }
}
