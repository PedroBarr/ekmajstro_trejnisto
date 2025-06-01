import 'package:ekmajstro_trejnisto/screens/segment_item/segment_item.dart';
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
const String ROUTER_SEGMENT_ITEM_SUB_PATH = '/segment';

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

const String ROUTER_SEGMENT_ITEM_SUB_ROUTE =
    '$ROUTER_SEGMENT_ITEM_SUB_PATH/$ROUTE_ID_WILDCARD';
const String ROUTER_SEGMENT_ADD_SUB_ROUTE =
    '$ROUTER_SEGMENT_ITEM_SUB_PATH/$ROUTE_ADD_WILDCARD';

const String ROUTER_SEGMENT_VIEW_ROUTE =
    '$ROUTER_SECTION_ITEM_SUB_ROUTE$ROUTER_SEGMENT_ITEM_SUB_ROUTE';
const String ROUTER_SEGMENT_ADD_ROUTE =
    '$ROUTER_SECTION_ITEM_SUB_ROUTE$ROUTER_SEGMENT_ADD_SUB_ROUTE';

const String ROUTER_TAG_ITEM_SUB_PATH = '/tags';
const String ROUTER_TAG_LIST_ROUTE =
    '$ROUTER_MAIN_ROUTE$ROUTER_TAG_ITEM_SUB_PATH';
const String ROUTER_TAG_VIEW_ROUTE =
    '$ROUTER_POST_VIEW_ROUTE$ROUTER_TAG_ITEM_SUB_PATH';

const String ROUTER_RESOURCE_ITEM_SUB_PATH = '/resources';
const String ROUTER_RESOURCE_LIST_ROUTE =
    '$ROUTER_MAIN_ROUTE$ROUTER_RESOURCE_ITEM_SUB_PATH';

Route<dynamic> mainRouter(RouteSettings settings) {
  if (settings.name == ROUTER_MAIN_ROUTE) {
    return mainRouter(const RouteSettings(
      name: ROUTER_POST_LIST_ROUTE,
    ));
  }

  if (settings.name == ROUTER_POST_LIST_ROUTE) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => const SafeArea(
        child: PostListScreen(),
      ),
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
        builder: (_) => const SafeArea(
          child: PostItemView(),
        ),
      );
    }

    if (isNumeric(wildCard)) {
      String subPath = subPathWithWildCard.substring(indexEndWildCard);

      if (['', '/'].contains(subPath)) {
        return MaterialPageRoute(
          builder: (_) => SafeArea(
            child: PostItemView(
              post_id: int.parse(wildCard),
            ),
          ),
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
          return MaterialPageRoute(
            builder: (_) => SafeArea(
              child: SectionItemView(
                post_id: int.parse(wildCard),
              ),
            ),
          );
        }

        if (isNumeric(wildCard2)) {
          String subPath2 = subPathWithWildCard2.substring(indexEndWildCard2);

          if (['', '/'].contains(subPath2)) {
            return MaterialPageRoute(
              builder: (_) => SafeArea(
                child: SectionItemView(
                  post_id: int.parse(wildCard),
                  section_id: int.parse(wildCard2),
                ),
              ),
            );
          }

          if (subPath2.contains('$ROUTER_SEGMENT_ITEM_SUB_PATH/')) {
            final String subPathWithWildCard3 =
                subPath2.replaceAll('$ROUTER_SEGMENT_ITEM_SUB_PATH/', '');

            final int indexEndWildCard3 = subPathWithWildCard3.contains('/')
                ? subPathWithWildCard3.indexOf('/')
                : subPathWithWildCard3.length;

            final String wildCard3 =
                subPathWithWildCard3.substring(0, indexEndWildCard3);

            if (wildCard3 == ROUTE_ADD_WILDCARD) {
              return MaterialPageRoute(
                builder: (_) => SafeArea(
                  child: SegmentItemView(
                    post_id: int.parse(wildCard),
                    section_id: int.parse(wildCard2),
                  ),
                ),
              );
            }

            if (isNumeric(wildCard3)) {
              String subPath3 =
                  subPathWithWildCard3.substring(indexEndWildCard3);

              if (['', '/'].contains(subPath3)) {
                return MaterialPageRoute(
                  builder: (_) => SafeArea(
                    child: SegmentItemView(
                      post_id: int.parse(wildCard),
                      section_id: int.parse(wildCard2),
                      segment_id: int.parse(wildCard3),
                    ),
                  ),
                );
              }
            }
          }
        }
      }

      if (subPath.contains('$ROUTER_TAG_ITEM_SUB_PATH')) {
        final String subPathWithWildCard2 =
            subPath.replaceAll('$ROUTER_TAG_ITEM_SUB_PATH', '');

        if (['', '/'].contains(subPathWithWildCard2)) {
          return MaterialPageRoute(
            builder: (_) => SafeArea(
              child: TagListScreen(
                post_id: int.parse(wildCard),
              ),
            ),
          );
        }
      }
    }
  }

  if (settings.name == ROUTER_TAG_LIST_ROUTE) {
    return MaterialPageRoute(
      builder: (_) => SafeArea(
        child: TagListScreen(),
      ),
    );
  }

  if (settings.name == '/app/resources') {
    return MaterialPageRoute(
      builder: (_) => SafeArea(
        child: ResourceListScreen(),
      ),
    );
  }

  return MaterialPageRoute(
    builder: (_) {
      return ROUTER_INITIAL_PAGE;
    },
  );
}
