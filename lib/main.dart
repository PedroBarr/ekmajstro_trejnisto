import 'package:flutter/material.dart';

import 'screens/screens.dart';
import 'themes/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: main_theme,
      home: const SplashscreenScreen(),
    );
  }
}
