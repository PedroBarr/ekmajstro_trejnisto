import 'package:flutter/material.dart';

import 'package:ekmajstro_trejnisto/screens/screens.dart';
import 'package:ekmajstro_trejnisto/themes/themes.dart';

const Widget ROUTER_INITIAL_PAGE = SplashscreenScreen();
const String ROUTER_MAIN_ROUTE = '/app';

Route<dynamic> mainRouter(RouteSettings settings) {
  if (settings.name == ROUTER_MAIN_ROUTE) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => const Scaffold(),
      transitionDuration:
          const Duration(milliseconds: SPLASHSCREEN_TRANSITION_MS),
      transitionsBuilder: fadeTransition,
      maintainState: true,
    );
  }

  return MaterialPageRoute(
    builder: (_) {
      return ROUTER_INITIAL_PAGE;
    },
  );
}
