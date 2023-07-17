import 'package:bloc/bloc.dart';
import 'package:monkeybox_final/Cubit/theme_cubit/theme_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart' as Material; // import with prefix

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(false));

  Future<void> initTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDark') ?? false;
    emit(ThemeState(isDark));
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = state.isDark;
    await prefs.setBool('isDark', !isDark);
    emit(ThemeState(!isDark));
  }

  Material.ThemeMode get themeMode =>
      state.isDark ? Material.ThemeMode.dark : Material.ThemeMode.light;
}