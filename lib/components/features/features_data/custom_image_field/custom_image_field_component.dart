import 'package:flutter/material.dart';

import 'custom_image_field_dialog.dart';
import 'package:ekmajstro_trejnisto/components/core/backdrop/backdrop.dart';

class CustomImageFieldComponent extends StatefulWidget {
  final double height;
  final String value;
  final Function? onConfirm;
  final String? title;

  const CustomImageFieldComponent({
    super.key,
    required this.height,
    this.value = '',
    this.onConfirm,
    this.title,
  });

  @override
  State<CustomImageFieldComponent> createState() =>
      _CustomImageFieldComponent();
}

class _CustomImageFieldComponent extends State<CustomImageFieldComponent> {
  bool _is_edit_dialog_open = false;
  bool _is_detail_dialog_open = false;

  final double _padding = 5.0;

  @override
  void initState() {
    super.initState();
  }

  void toggleEditOpen(dynamic value) {
    setState(() {
      if ([true, false].contains(value)) {
        _is_edit_dialog_open = value;
      } else {
        _is_edit_dialog_open = !_is_edit_dialog_open;
      }

      if (_is_edit_dialog_open) {
        BackdropComponent.showDialog(
          context: context,
          child: CustomImageFieldDialog(),
          onBackdropTap: () => toggleEditOpen(false),
        );
      } else {
        BackdropComponent.hideDialog();
      }
    });
  }

  void toggleDetailOpen(dynamic value) {
    setState(() {
      if ([true, false].contains(value)) {
        _is_detail_dialog_open = value;
      } else {
        _is_detail_dialog_open = !_is_detail_dialog_open;
      }

      if (_is_detail_dialog_open) {
        BackdropComponent.showDialog(
          context: context,
          child: CustomImageFieldDialog(
            mode: 'detail',
            value: widget.value,
            title: widget.title,
          ),
          onBackdropTap: () => toggleDetailOpen(false),
        );
      } else {
        BackdropComponent.hideDialog();
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
                      onTap: () => toggleEditOpen(null),
                      child: Icon(
                        Icons.library_add,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    );
                  } else {
                    return GestureDetector(
                      onTap: () => toggleDetailOpen(null),
                      child: Image.network(
                        widget.value,
                        height: widget.height - 2 * _padding,
                        fit: BoxFit.fitHeight,
                      ),
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
                            onTap: () => toggleEditOpen(null),
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
      ],
    );
  }
}
