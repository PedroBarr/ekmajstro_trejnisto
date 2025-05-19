import 'package:flutter/widgets.dart';

class AccordionElement {
  Widget content;
  String name;
  bool is_expanded;

  AccordionElement({
    required this.content,
    this.name = '',
    this.is_expanded = false,
  });
}
