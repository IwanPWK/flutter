import 'package:flutter/material.dart';

import 'dark_mode.dart';
import 'light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  // initially, light mode
  ThemeData _themeData = lightMode;

  // get current theme
  ThemeData get getTheme => _themeData;

  // check if current theme is dark mode
  bool get isDarkMode => _themeData == darkMode;

  // set theme
  set setTheme(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  // toggle theme
  void toggleTheme() {
    _themeData = isDarkMode ? lightMode : darkMode;
    notifyListeners();
  }
}
