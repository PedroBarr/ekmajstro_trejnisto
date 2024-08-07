import 'package:flutter/material.dart';

import 'package:ekmajstro_trejnisto/screens/screens.dart';

const Widget ROUTER_INITIAL_PAGE = SplashscreenScreen();
const Widget ROUTER_MAIN_PAGE = Scaffold();

Route<dynamic> mainRouter(RouteSettings settings) {
  return MaterialPageRoute(
    builder: (_) {
      return ROUTER_INITIAL_PAGE;
    },
  );
}
