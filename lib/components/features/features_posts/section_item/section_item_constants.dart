import 'package:flutter/material.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';
import 'package:ekmajstro_trejnisto/utils/utils.dart';

void navigateToSection(BuildContext context, String route) {
  Navigator.of(context).pushNamed(route);
}

String sectionBuildRoute(Post post, {SectionItem? section}) {
  List<String> subpaths = [
    buildIdRoute(ROUTER_POST_VIEW_ROUTE, PostItem.fromJson(post.toMap(false))),
    (section == null
        ? ROUTER_SECTION_ADD_SUB_ROUTE
        : buildIdRoute(ROUTER_SECTION_ITEM_SUB_ROUTE, section)),
  ];

  return buildSubRoute(subpaths);
}
