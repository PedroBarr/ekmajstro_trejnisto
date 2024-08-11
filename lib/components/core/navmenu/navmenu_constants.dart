import 'package:flutter/material.dart';

import 'package:ekmajstro_trejnisto/config/config.dart';
import 'package:ekmajstro_trejnisto/models/models.dart';
import 'package:ekmajstro_trejnisto/themes/themes.dart';
import 'package:ekmajstro_trejnisto/utils/utils.dart';

List<NavItemModel> NAVMENU_ITEMS_LIST = [
  NavItemModel(
    icon: Icon(
      Icons.art_track_rounded,
      color: main_theme.scaffoldBackgroundColor,
    ),
    title: NAV_ITEM_POSTS_LABEL,
    location: ROUTER_POST_LIST_ROUTE,
  ),
];
