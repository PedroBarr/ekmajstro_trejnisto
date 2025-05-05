import 'package:flutter/material.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';

import 'navmenu_constants.dart';
import 'navitem_component.dart';

class NavmenuComponent extends StatefulWidget {
  final double width;
  final double height;
  final VoidCallback? onNavItemTap;

  const NavmenuComponent({
    super.key,
    required this.width,
    required this.height,
    this.onNavItemTap,
  });

  @override
  State<NavmenuComponent> createState() => _NavmenuComponent();
}

class _NavmenuComponent extends State<NavmenuComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Wrap(
          direction: Axis.vertical,
          spacing: 10.0,
          alignment: WrapAlignment.center,
          children: NAVMENU_ITEMS_LIST
              .map(
                (NavItemModel item) => NavitemComponent(
                  nav_item: item,
                  width: widget.width,
                  onNavItemTap: () {
                    if (widget.onNavItemTap != null) {
                      widget.onNavItemTap!();
                    }
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
