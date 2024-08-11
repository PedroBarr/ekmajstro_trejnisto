import 'package:flutter/material.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';

class NavitemComponent extends StatefulWidget {
  final NavItemModel nav_item;
  final double width;

  const NavitemComponent({
    super.key,
    required this.nav_item,
    required this.width,
  });

  @override
  State<NavitemComponent> createState() => _NavitemComponent();
}

class _NavitemComponent extends State<NavitemComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          style: BorderStyle.solid,
          color: Theme.of(context).scaffoldBackgroundColor,
          width: 1.0,
        ),
        color: Theme.of(context).primaryColor,
      ),
      padding: const EdgeInsets.all(10.0),
      width: widget.width,
      child: Row(
        children: [
          const SizedBox(width: 10.0),
          widget.nav_item.icon,
          const SizedBox(width: 10.0),
          Text(
            (widget.nav_item.title).toUpperCase(),
            style: TextStyle(
              fontSize: 16.0,
              letterSpacing: 2,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
          const Spacer(),
          Icon(
            Icons.chevron_right_rounded,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          const SizedBox(width: 10.0),
        ],
      ),
    );
  }
}
