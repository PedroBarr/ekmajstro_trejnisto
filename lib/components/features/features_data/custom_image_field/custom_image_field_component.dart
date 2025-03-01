import 'package:flutter/material.dart';

import 'custom_image_field_dialog.dart';
import 'package:ekmajstro_trejnisto/components/core/backdrop/backdrop.dart';

class CustomImageFieldComponent extends StatefulWidget {
  double height;
  String value;
  final Function? onConfirm;

  CustomImageFieldComponent({
    super.key,
    required this.height,
    this.value = '',
    this.onConfirm,
  });

  @override
  State<CustomImageFieldComponent> createState() =>
      _CustomImageFieldComponent();
}

class _CustomImageFieldComponent extends State<CustomImageFieldComponent> {
  bool _is_dialog_open = false;

  double _padding = 5.0;

  @override
  void initState() {
    super.initState();
  }

  void toggleMenuOpen(dynamic value) {
    setState(() {
      if ([true, false].contains(value)) {
        _is_dialog_open = value;
      } else {
        _is_dialog_open = !_is_dialog_open;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(_padding),
              height: widget.height,
              child: Builder(
                builder: (context) {
                  if (widget.value.isEmpty) {
                    return GestureDetector(
                      onTap: () => toggleMenuOpen(null),
                      child: Icon(
                        Icons.library_add,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    );
                  } else {
                    return Image.network(
                      widget.value,
                      height: widget.height - 2 * _padding,
                      fit: BoxFit.fitHeight,
                    );
                  }
                },
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 5.0,
                  children: [
                    Builder(
                      builder: (context) {
                        if (widget.value.isEmpty) {
                          return Container();
                        } else {
                          return GestureDetector(
                            onTap: () => toggleMenuOpen(null),
                            child: Icon(
                              Icons.edit_square,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        BackdropComponent(
          is_showing: _is_dialog_open,
          child: CustomImageFieldDialog(),
          onBackdropTap: () => toggleMenuOpen(false),
        ),
      ],
    );
  }
}
