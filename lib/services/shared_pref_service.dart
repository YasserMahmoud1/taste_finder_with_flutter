import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static ThemeMode getTheme() {
    final theme = _prefs!.getString("theme");
    if (theme == "light") {
      return ThemeMode.light;
    } else if (theme == "dark") {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  static String getThemeString() => _prefs!.getString("theme") ?? "sys";

  static Future<bool> setTheme(String newTheme) async {
    return await _prefs!.setString("theme", newTheme);
  }

  static String getLocaleCode() => _prefs!.getString("localeCode") ?? "sys";

  static Future<bool> setLocaleCode(String newCode) async {
    return await _prefs!.setString("localeCode", newCode);
  }
}
