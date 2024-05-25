import 'package:flutter/material.dart';

// TODO: Add proper theme.
class TwoTheme {
  static ThemeData themeDark = ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: Colors.white,
      onPrimary: Colors.black,
      secondary: Colors.black,
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      background: Colors.black,
      onBackground: Colors.white,
      surface: Colors.grey.shade800,
      onSurface: Colors.white,
    ),
  );
}
