import 'package:flutter/material.dart';
import '../services/theme_preferences_service.dart';

class ThemeProvider extends ChangeNotifier {
  final ThemePreferencesService _prefsService;

  ThemeMode _themeMode = ThemeMode.dark;

  ThemeMode get themeMode => _themeMode;
  bool get isDark => _themeMode == ThemeMode.dark;

  ThemeProvider({ThemePreferencesService? prefsService})
      : _prefsService = prefsService ?? ThemePreferencesService() {
    _loadTheme();
  }

  void toggleTheme() async {
    _themeMode = isDark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();

    await _prefsService.saveTheme(isDark);
  }

  Future<void> _loadTheme() async {
    final isDarkSaved = await _prefsService.loadTheme();
    _themeMode = isDarkSaved ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}