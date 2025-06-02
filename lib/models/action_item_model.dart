import 'package:flutter/material.dart';

class ActionItemModel {
  final String label;
  final Function? onTap;
  final IconData? icon;
  final Color? back_color;
  final Color? color;
  final bool pop_on_tap;

  const ActionItemModel({
    required this.label,
    this.onTap,
    this.icon,
    this.back_color,
    this.color,
    this.pop_on_tap = true,
  });
}
