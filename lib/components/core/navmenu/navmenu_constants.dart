import 'package:ekmajstro_trejnisto/config/config.dart';
import 'package:ekmajstro_trejnisto/models/models.dart';
import 'package:ekmajstro_trejnisto/themes/main_theme.dart';
import 'package:ekmajstro_trejnisto/utils/utils.dart';

List<NavItemModel> NAVMENU_ITEMS_LIST = [
  NavItemModel(
    icon: iconNavPostList(main_theme.scaffoldBackgroundColor),
    title: NAV_ITEM_POSTS_LABEL,
    location: ROUTER_POST_LIST_ROUTE,
  ),
  NavItemModel(
    icon: iconNavTagList(main_theme.scaffoldBackgroundColor),
    title: NAV_ITEM_TAGS_LABEL,
    location: ROUTER_TAG_LIST_ROUTE,
  ),
];
