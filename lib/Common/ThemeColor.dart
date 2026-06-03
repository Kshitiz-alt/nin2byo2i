//common theme color of app
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager {
  // static Color _themeColor = const Color(0xff1D1617);
  // static Color _themelightColor = const Color(0xff1D1617);
  static Color _themeColor = Colors.white;
  static Color _themelightColor = const Color(0xFFF7F8F8);
  static Color _themeText = Colors.black;

  static set blackTheme(bool isBlack) {
    if (isBlack) {
      _themeColor = const Color.fromARGB(255, 66, 64, 64);
      _themelightColor = const Color.fromARGB(255, 91, 92, 92);
      _themeText = Colors.white;
    } else {
      _themeColor = Colors.white;
      _themelightColor = const Color.fromARGB(255, 244, 245, 245);
      _themeText = Colors.black;
    }

    // Save the theme preference in SharedPreferences
    _saveThemePreference(isBlack);
  }

  static Color get themeColor => _themeColor;
  static Color get themelightColor => _themelightColor;
  static Color get themeText => _themeText;

  static Future<void> _saveThemePreference(bool isBlack) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isBlackTheme', isBlack);
  }

  static Future<void> loadThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final isBlackTheme = prefs.getBool('isBlackTheme');
    if (isBlackTheme != null) {
      blackTheme = isBlackTheme;
    }
  }
}
