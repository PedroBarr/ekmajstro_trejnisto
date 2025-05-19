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
      child: Wrap(
        direction: Axis.vertical,
        spacing: 10.0,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: widget.sections.map<Widget>((section) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            padding: const EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width - 20.0,
            child: Text(
              section.name,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
