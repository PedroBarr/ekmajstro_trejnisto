import 'package:flutter/material.dart';

import 'add_resource_item_component.dart';
import 'resource_item_component.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';

class ResourceItemListComponent extends StatefulWidget {
  final List<ResourceItem> resources;
  final bool include_add;
  final List<ResourceItem>? selected_resources;

  const ResourceItemListComponent({
    super.key,
    required this.resources,
    this.include_add = false,
    this.selected_resources,
  });

  @override
  State<ResourceItemListComponent> createState() =>
      _ResourceItemListComponent();
}

class _ResourceItemListComponent extends State<ResourceItemListComponent> {
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
            widget.resources.map<Widget>((resource) {
              return ResourceItemComponent(
                resource: resource,
                is_selected: widget.selected_resources != null &&
                    widget.selected_resources!.contains(resource),
              );
            }).toList(),
            [
              Builder(
                builder: (context) {
                  return widget.include_add
                      ? AddResourceItemComponent()
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

  List<ResourceItem> getSortedResources() {
    List<ResourceItem> resources = widget.resources.toList();

    if (widget.selected_resources != null) {
      resources.sort((a, b) {
        int aIndex = widget.selected_resources!.indexOf(a);
        int bIndex = widget.selected_resources!.indexOf(b);

        if (aIndex == -1 && bIndex == -1) {
          return 0; // Neither is selected
        } else if (aIndex == -1) {
          return 1; // a is not selected, b is selected
        } else if (bIndex == -1) {
          return -1; // b is not selected, a is selected
        } else {
          return aIndex.compareTo(bIndex); // Both are selected, sort by index
        }
      });
    }

    return resources;
  }
}
