import 'package:flutter/material.dart';

class ActionItemModel {
  final String label;
  final Function? onTap;
  final IconData? icon;
  final Color? backColor;
  final Color? color;

  const ActionItemModel({
    required this.label,
    this.onTap,
    this.icon,
    this.backColor,
    this.color,
  });
}
