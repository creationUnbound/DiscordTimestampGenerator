import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  bool isDark = true;

  ThemeMode currentTheme() => isDark ? ThemeMode.dark : ThemeMode.light;

  void switchTheme() {
    isDark = !isDark;
    notifyListeners();
  }
}
