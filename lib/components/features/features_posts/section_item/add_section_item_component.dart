import 'package:flutter/material.dart';

import 'section_item_constants.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';

class AddSectionItemComponent extends StatefulWidget {
  final Post post;

  const AddSectionItemComponent({
    super.key,
    required this.post,
  });

  @override
  State<AddSectionItemComponent> createState() => _AddSectionItemComponent();
}

class _AddSectionItemComponent extends State<AddSectionItemComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateToSection(
          context,
          sectionBuildRoute(widget.post),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(
          left: 10.0,
          right: 10.0,
        ),
        width: MediaQuery.of(context).size.width,
        child: Container(
          height: 40.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              style: BorderStyle.solid,
              color: Theme.of(context).colorScheme.onPrimary,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
