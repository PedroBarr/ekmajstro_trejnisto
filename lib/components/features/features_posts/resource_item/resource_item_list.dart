import 'package:flutter/material.dart';

import 'add_resource_item_component.dart';
import 'resource_item_component.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';

class ResourceItemListComponent extends StatefulWidget {
  final List<ResourceItem> resources;
  final bool include_add;
  final String? post_id;
  final List<ResourceItem>? selected_resources;
  final Function(ResourceItem)? onTap;

  const ResourceItemListComponent({
    super.key,
    required this.resources,
    this.include_add = false,
    this.post_id,
    this.selected_resources,
    this.onTap,
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
            getSortedResources().map<Widget>((resource) {
              return ResourceItemComponent(
                resource: resource,
                is_selected: isSelected(resource),
                onTap: (ResourceItem resource) {
                  if (widget.onTap != null) {
                    widget.onTap!(resource);
                  }
                },
              );
            }).toList(),
            [
              Builder(
                builder: (context) {
                  return widget.include_add
                      ? AddResourceItemComponent(
                          post_id: widget.post_id,
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

  List<ResourceItem> getSortedResources() {
    List<ResourceItem> resources = widget.resources.toList();

    if (widget.selected_resources != null) {
      resources = [
        ...widget.selected_resources!,
        ...resources.where((resource) =>
            !widget.selected_resources!.any((r) => r.id == resource.id))
      ];
    }

    return resources;
  }

  bool isSelected(ResourceItem resource) {
    if (widget.selected_resources == null) return false;
    return widget.selected_resources!
        .any((ResourceItem r) => r.id == resource.id);
  }
}
