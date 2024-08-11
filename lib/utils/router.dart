import 'dart:io';

import 'package:flutter/material.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';
import 'package:ekmajstro_trejnisto/screens/screens.dart';
import 'package:ekmajstro_trejnisto/themes/themes.dart';

const Widget ROUTER_INITIAL_PAGE = SplashscreenScreen();
const String ROUTER_MAIN_ROUTE = '/app';
const String ROUTE_ID_WILDCARD = ':id';
const String ROUTER_POST_LIST_ROUTE = '/app/posts';
const String ROUTER_POST_ITEM_ROUTE = '/app/post';
const String ROUTER_POST_VIEW_ROUTE =
    '$ROUTER_POST_ITEM_ROUTE/$ROUTE_ID_WILDCARD';

String buildIdRoute(String route_base, ModelItem item) {
  return route_base.replaceAll(ROUTE_ID_WILDCARD, item.id.toString());
}

Route<dynamic> mainRouter(RouteSettings settings) {
  if (settings.name == ROUTER_MAIN_ROUTE) {
    return mainRouter(const RouteSettings(
      name: ROUTER_POST_LIST_ROUTE,
    ));
  }

  if (settings.name == ROUTER_POST_LIST_ROUTE) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => const PostListScreen(),
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
