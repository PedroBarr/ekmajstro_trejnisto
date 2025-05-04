import 'package:flutter/material.dart';

final ThemeData main_theme = ThemeData(
  scaffoldBackgroundColor: const Color(0xFF242424),
  primaryColor: const Color(0xFF545A70),
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      inherit: true,
      color: Color(0xFF1F1D2A),
    ),
    headlineLarge: TextStyle(inherit: true, color: Color(0xFF1F1D2A)),
  ),
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF555555),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFF545A70),
    onSecondary: Color(0xFFDADADA),
    error: Color(0xAAFA5A65),
    onError: Color(0xFF1F1D2A),
    surface: Color(0xFF555555),
    onSurface: Color(0xFFFFEE66),
  ),
  appBarTheme: const AppBarTheme(
    centerTitle: true,
  ),
  useMaterial3: true,
  dialogTheme: const DialogThemeData(backgroundColor: Color(0x99545A70)),
);
