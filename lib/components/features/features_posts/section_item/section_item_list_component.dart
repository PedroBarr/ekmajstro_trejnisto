import 'package:flutter/material.dart';

import 'section_item_constants.dart';
import 'add_section_item_component.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';

class SectionItemListComponent extends StatefulWidget {
  final List<SectionItem> sections;
  final Post post;
  final bool include_add;

  const SectionItemListComponent({
    super.key,
    required this.sections,
    required this.post,
    this.include_add = false,
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
          children: [
            [
              const SizedBox(
                height: 5,
              ),
            ],
            widget.sections.map<Widget>((section) {
              return GestureDetector(
                onTap: () {
                  navigateToSection(context,
                      sectionBuildRoute(widget.post, section: section));
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
                        section.name,
                        style: TextStyle(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Builder(
                        builder: (BuildContext context) {
                          return section.is_mark_one
                              ? Icon(
                                  Icons.stars,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                )
                              : SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            [
              Builder(
                builder: (context) {
                  return widget.include_add
                      ? AddSectionItemComponent(
                          post: widget.post,
                        )
                      : SizedBox.shrink();
                },
              ),
              const SizedBox(
                height: 5,
              ),
            ]
          ].expand((x) => x).toList()),
    );
  }
}
