import 'package:flutter/material.dart';

import 'themes/themes.dart';
import 'utils/utils.dart';

void main() {
  runApp(const Trejnisto());
}

class Trejnisto extends StatelessWidget {
  const Trejnisto({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ekmajstro - Trejnisto',
      theme: main_theme,
      home: ROUTER_INITIAL_PAGE,
      onGenerateRoute: mainRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
