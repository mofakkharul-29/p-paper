import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends Notifier<ThemeMode> {
  static const _key = 'theme_mode';

  @override
  ThemeMode build() {
    _loadTheme();
    return ThemeMode.light;
  }

  void toggleTheme(bool isDark) async {
    final SharedPreferences pref =
        await SharedPreferences.getInstance();

    final mode = isDark ? ThemeMode.dark : ThemeMode.light;
    await pref.setBool(_key, isDark);
    state = mode;
  }

  void _loadTheme() async {
    final SharedPreferences pref =
        await SharedPreferences.getInstance();

    final bool isDark = pref.getBool(_key) ?? false;

    state = isDark ? ThemeMode.dark : ThemeMode.light;
  }
}

final themeNotifierProvider =
    NotifierProvider<ThemeNotifier, ThemeMode>(
      ThemeNotifier.new,
    );
