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
const String ROUTER_SECTION_ITEM_SUB_PATH = '/section';

const String ROUTER_POST_VIEW_ROUTE =
    '$ROUTER_POST_ITEM_ROUTE/$ROUTE_ID_WILDCARD';
const String ROUTER_POST_ADD_ROUTE =
    '$ROUTER_POST_ITEM_ROUTE/$ROUTE_ADD_WILDCARD';

const String ROUTER_SECTION_ITEM_SUB_ROUTE =
    '$ROUTER_SECTION_ITEM_SUB_PATH/$ROUTE_ID_WILDCARD';
const String ROUTER_SECTION_ADD_SUB_ROUTE =
    '$ROUTER_SECTION_ITEM_SUB_PATH/$ROUTE_ADD_WILDCARD';

const String ROUTER_SECTION_VIEW_ROUTE =
    '$ROUTER_POST_VIEW_ROUTE$ROUTER_SECTION_ITEM_SUB_ROUTE';
const String ROUTER_SECTION_ADD_ROUTE =
    '$ROUTER_POST_VIEW_ROUTE$ROUTER_SECTION_ADD_SUB_ROUTE';

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

  if (settings.name!.contains('$ROUTER_POST_ITEM_ROUTE/')) {
    final String path = settings.name ?? '';

    final String subPathWithWildCard =
        path.replaceAll('$ROUTER_POST_ITEM_ROUTE/', '');

    final int indexEndWildCard = subPathWithWildCard.contains('/')
        ? subPathWithWildCard.indexOf('/')
        : subPathWithWildCard.length;

    final String wildCard = subPathWithWildCard.substring(0, indexEndWildCard);

    if (wildCard == ROUTE_ADD_WILDCARD) {
      return MaterialPageRoute(
        builder: (_) => const PostItemView(),
      );
    }

    if (isNumeric(wildCard)) {
      String subPath = subPathWithWildCard.substring(indexEndWildCard);

      if (['', '/'].contains(subPath)) {
        return MaterialPageRoute(
          builder: (_) => PostItemView(post_id: int.parse(wildCard)),
        );
      }

      if (subPath.contains('$ROUTER_SECTION_ITEM_SUB_PATH/')) {
        final String subPathWithWildCard2 =
            subPath.replaceAll('$ROUTER_SECTION_ITEM_SUB_PATH/', '');

        final int indexEndWildCard2 = subPathWithWildCard2.contains('/')
            ? subPathWithWildCard2.indexOf('/')
            : subPathWithWildCard2.length;

        final String wildCard2 =
            subPathWithWildCard2.substring(0, indexEndWildCard2);

        if (wildCard2 == ROUTE_ADD_WILDCARD) {
          debugPrint('Add section');
        }

        if (isNumeric(wildCard2)) {
          debugPrint('View section');
        }
      }
    }
  }

  return MaterialPageRoute(
    builder: (_) {
      return ROUTER_INITIAL_PAGE;
    },
  );
}
