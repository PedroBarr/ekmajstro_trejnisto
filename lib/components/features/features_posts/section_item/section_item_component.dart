import 'package:flutter/material.dart';

import 'section_item_constants.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';

class SectionItemComponent extends StatefulWidget {
  final Post post;
  final SectionItem section;

  const SectionItemComponent({
    super.key,
    required this.post,
    required this.section,
  });

  @override
  State<SectionItemComponent> createState() => _SectionItemComponent();
}

class _SectionItemComponent extends State<SectionItemComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateToSection(
            context, sectionBuildRoute(widget.post, section: widget.section));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        padding: const EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width - 20.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.section.name,
              style: TextStyle(
                color: Theme.of(context).scaffoldBackgroundColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Builder(
              builder: (BuildContext context) {
                return widget.section.is_mark_one
                    ? Icon(
                        Icons.stars,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      )
                    : SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
