import 'package:flutter/material.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';

class SectionItemListComponent extends StatefulWidget {
  final List<SectionItem> sections;

  const SectionItemListComponent({
    super.key,
    required this.sections,
  });

  @override
  State<SectionItemListComponent> createState() => _SectionItemListComponent();
}

class _SectionItemListComponent extends State<SectionItemListComponent> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: widget.sections.map<Widget>((section) {
          return Text(section.name);
        }).toList(),
      ),
    );
  }
}
