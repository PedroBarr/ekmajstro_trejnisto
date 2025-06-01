import 'package:flutter/material.dart';

class SectionItemComponent extends StatefulWidget {
  const SectionItemComponent({
    super.key,
  });

  @override
  State<SectionItemComponent> createState() => _SectionItemComponent();
}

class _SectionItemComponent extends State<SectionItemComponent> {
  @override
  Widget build(BuildContext context) {
    return const Text("Section Item Component");
  }
}
