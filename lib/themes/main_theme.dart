import 'package:flutter/material.dart';

final ThemeData main_theme = ThemeData(
  primaryColor: const Color(0xFF000000),
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      inherit: true,
      color: Color(0xFFFFFFFF),
    ),
  ),
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF000000),
    onPrimary: Color(0xFF000000),
    secondary: Color(0xFF000000),
    onSecondary: Color(0xFF000000),
    error: Color(0xFF000000),
    onError: Color(0xFF000000),
    surface: Color(0xFF000000),
    onSurface: Color(0xFF000000),
  ),
  useMaterial3: true,
);
