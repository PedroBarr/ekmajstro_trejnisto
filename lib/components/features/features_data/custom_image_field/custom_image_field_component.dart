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
        BackdropComponent(
          is_showing: _is_dialog_open,
          child: CustomImageFieldDialog(),
          onBackdropTap: () => toggleMenuOpen(false),
        ),
      ],
    );
  }
}
