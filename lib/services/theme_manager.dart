import 'package:flutter/material.dart';

class ThemeManager {
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.deepOrangeAccent,
      type: BottomNavigationBarType.fixed,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.deepOrangeAccent),
    // splashFactory: InkRipple.splashFactory,
    brightness: Brightness.dark,
    searchBarTheme: SearchBarThemeData(
      backgroundColor: WidgetStateProperty.all(
        Colors.grey[850],
      ),
      textStyle: WidgetStateProperty.all(
        TextStyle(color: Colors.white),
      ),
    ),
    searchViewTheme: SearchViewThemeData(
      headerTextStyle: TextStyle(color: Colors.white),
    ),
  );

  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
    ),
    // splashFactory: InkRipple.splashFactory,
    progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.deepOrangeAccent),
    searchBarTheme: SearchBarThemeData(
      backgroundColor: WidgetStateProperty.all(
        Colors.grey.shade200,
      ),
    ),
    brightness: Brightness.light,
    searchViewTheme: SearchViewThemeData(
      headerTextStyle: TextStyle(color: Colors.black),
    ),
  );
}
