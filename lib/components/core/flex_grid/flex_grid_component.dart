import 'package:flutter/material.dart';

import 'flex_grid_utils.dart';

class _FlexGridDelegate extends MultiChildLayoutDelegate {
  final List<FlexGridSize> itemSizes;
  final double deltaCurrentRow = 0.01;

  _FlexGridDelegate(this.itemSizes);

  @override
  void performLayout(Size size) {
    double currentY = 0.0;
    double currentX = 0.0;
    double maxHeightInCurrentRow = 0.0;
    double availableWidth = size.width;

    for (int i = 0; i < itemSizes.length; i++) {
      final FlexGridSize itemSize = itemSizes[i];

      double itemWidth = 0.0;
      double remainingWidthInRow = availableWidth - currentX;

      switch (itemSize) {
        case FlexGridSize.full:
          itemWidth = availableWidth;
          break;
        case FlexGridSize.half:
          itemWidth = availableWidth / 2;
          break;
        case FlexGridSize.third:
          itemWidth = availableWidth / 3;
          break;
      }

      if (itemWidth > remainingWidthInRow + deltaCurrentRow ||
          (itemSize == FlexGridSize.full && currentX > 0)) {
        currentX = 0.0;
        currentY += maxHeightInCurrentRow;
        maxHeightInCurrentRow = 0.0;
      }

      final Size childSize = layoutChild(
        i,
        BoxConstraints(
          maxWidth: itemWidth,
          minWidth: itemWidth,
        ),
      );

      positionChild(i, Offset(currentX, currentY));

      maxHeightInCurrentRow = childSize.height > maxHeightInCurrentRow
          ? childSize.height
          : maxHeightInCurrentRow;

      currentX += itemWidth;

      if (currentX > availableWidth) {
        currentX = 0.0;
        currentY += maxHeightInCurrentRow;
        maxHeightInCurrentRow = 0.0;
      }
    }

    currentY += maxHeightInCurrentRow;

    size = Size(size.width, currentY);
  }

  @override
  bool shouldRelayout(_FlexGridDelegate oldDelegate) {
    return itemSizes != oldDelegate.itemSizes;
  }
}

class FlexGrid extends StatelessWidget {
  final List<FlexGridItem> children;

  const FlexGrid({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final List<FlexGridSize> itemSizes =
        children.map((item) => item.size).toList();

    return CustomMultiChildLayout(
      delegate: _FlexGridDelegate(itemSizes),
      children: _buildLayoutChildren(),
    );
  }

  List<Widget> _buildLayoutChildren() {
    return children.asMap().entries.map((entry) {
      final int index = entry.key;
      final FlexGridItem item = entry.value;
      return LayoutId(
        id: index,
        child: item,
      );
    }).toList();
  }
}
