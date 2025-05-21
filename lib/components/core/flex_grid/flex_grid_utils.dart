import 'package:flutter/material.dart';

enum FlexGridSize {
  full,
  half,
  third,
}

class FlexGridItem extends StatelessWidget {
  final FlexGridSize size;
  final Widget child;

  const FlexGridItem({
    super.key,
    required this.size,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
