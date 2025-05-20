import 'package:flutter/material.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';
import 'package:ekmajstro_trejnisto/utils/utils.dart';

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
  void navigateToSection(BuildContext context, String route) {
    Navigator.of(context).pushNamed(route);
  }

  String _buildRoute({SectionItem? section}) {
    List<String> subpaths = [
      buildIdRoute(
          ROUTER_POST_VIEW_ROUTE, PostItem.fromJson(widget.post.toMap(false))),
      (section == null
          ? ROUTER_SECTION_ADD_SUB_ROUTE
          : buildIdRoute(ROUTER_SECTION_ITEM_SUB_ROUTE, section)),
    ];

    return buildSubRoute(subpaths);
  }

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
                  navigateToSection(context, _buildRoute(section: section));
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
                      ? GestureDetector(
                          onTap: () {
                            navigateToSection(
                              context,
                              _buildRoute(),
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
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
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
