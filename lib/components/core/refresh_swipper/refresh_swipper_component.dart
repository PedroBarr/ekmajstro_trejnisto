import 'package:flutter/material.dart';

class RefreshSwipperComponent extends StatefulWidget {
  final Widget child;
  final Function()? onRefresh;
  final bool refreshing;

  const RefreshSwipperComponent({
    super.key,
    required this.child,
    this.onRefresh,
    this.refreshing = false,
  });

  @override
  State<RefreshSwipperComponent> createState() =>
      _RefreshSwipperComponentState();
}

class _RefreshSwipperComponentState extends State<RefreshSwipperComponent> {
  double _MAX_DRAG_OFFSET = 100;
  double _drag_offset = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: (_) {
        if (!widget.refreshing && mounted) {
          setState(() {
            _drag_offset = 0;
          });
        }
      },
      onVerticalDragUpdate: (details) {
        if (!widget.refreshing && details.delta.dy > 0 && mounted) {
          setState(() {
            _drag_offset = (_drag_offset + details.delta.dy)
                .clamp(0, _MAX_DRAG_OFFSET * 1.5);
          });
        }
      },
      onVerticalDragEnd: (_) {
        if (!widget.refreshing && mounted) {
          if (_drag_offset > _MAX_DRAG_OFFSET) {
            widget.onRefresh?.call();
          }

          setState(() {
            _drag_offset = 0;
          });
        }
      },
      child: widget.child,
    );
  }
}
