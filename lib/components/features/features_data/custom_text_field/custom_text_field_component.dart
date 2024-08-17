import 'package:flutter/material.dart';

class CustomTextFieldComponent extends StatefulWidget {
  String value;
  final Function? onConfirm;

  CustomTextFieldComponent({
    super.key,
    this.value = '',
    this.onConfirm,
  });

  @override
  State<CustomTextFieldComponent> createState() => _CustomTextFieldComponent();
}

class _CustomTextFieldComponent extends State<CustomTextFieldComponent> {
  String _value = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector();
  }
}
