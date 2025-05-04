import 'package:flutter/material.dart';

import 'package:ekmajstro_trejnisto/screens/screens.dart';
import 'package:ekmajstro_trejnisto/themes/themes.dart';
import 'misc.dart';

const Widget ROUTER_INITIAL_PAGE = SplashscreenScreen();
const String ROUTER_MAIN_ROUTE = '/app';
const String ROUTE_ID_WILDCARD = ':id';
const String ROUTE_ADD_WILDCARD = ':id';
const String ROUTER_POST_LIST_ROUTE = '/app/posts';
const String ROUTER_POST_ITEM_ROUTE = '/app/post';
const String ROUTER_POST_VIEW_ROUTE =
    '$ROUTER_POST_ITEM_ROUTE/$ROUTE_ID_WILDCARD';
const String ROUTER_POST_ADD_ROUTE =
    '$ROUTER_POST_ITEM_ROUTE/$ROUTE_ADD_WILDCARD';

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

  if (settings.name!.contains(ROUTER_POST_ITEM_ROUTE)) {
    final String path = settings.name ?? '';
    final int indexPath = path.indexOf('$ROUTER_POST_ITEM_ROUTE/');
    final String subPath = path.replaceAll('$ROUTER_POST_ITEM_ROUTE/', '');
    final int indexSuperPath = subPath.indexOf('/', indexPath);
    final String wildcard;

    if ([-1, indexPath].contains(indexSuperPath)) {
      wildcard = subPath;
    } else {
      wildcard = subPath.substring(indexPath, indexSuperPath);
    }

    if (wildcard == ROUTE_ADD_WILDCARD) {
      return MaterialPageRoute(
        builder: (_) => const PostItemView(),
      );
    }

    if (isNumeric(wildcard)) {
      return MaterialPageRoute(
        builder: (_) => PostItemView(post_id: int.parse(wildcard)),
      );
    }
  }

  return MaterialPageRoute(
    builder: (_) {
      return ROUTER_INITIAL_PAGE;
    },
  );
}
