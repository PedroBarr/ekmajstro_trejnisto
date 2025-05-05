import 'package:flutter/material.dart';

import 'dart:ui' as ui show ImageFilter;

class BackdropComponent {
  static OverlayEntry? _overlayEntry;
  static bool _is_showing = false;

  static void showDialog({
    required BuildContext context,
    required Widget child,
    VoidCallback? onBackdropTap,
  }) {
    if (_is_showing) {
      return;
    }
    _is_showing = true;
    final OverlayState? overlayState = Overlay.of(context);
    if (overlayState != null) {
      _overlayEntry = OverlayEntry(builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: onBackdropTap,
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(
                    sigmaX: 3.0,
                    sigmaY: 3.0,
                  ),
                  child: Container(
                    color: Theme.of(context)
                        .dialogBackgroundColor
                        .withOpacity(0.4),
                  ),
                ),
              ),
            ),
            Center(
              child: child,
            )
          ],
        );
      });
      overlayState.insert(_overlayEntry!);
    }
  }

  static void hideDialog() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      _is_showing = false;
    }
  }
}
