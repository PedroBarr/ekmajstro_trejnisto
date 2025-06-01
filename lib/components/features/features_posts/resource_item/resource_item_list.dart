import 'package:flutter/material.dart';

import 'add_resource_item_component.dart';
import 'resource_item_component.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';

class ResourceItemListComponent extends StatefulWidget {
  final List<ResourceItem> resources;
  final bool include_add;

  const ResourceItemListComponent({
    super.key,
    required this.resources,
    this.include_add = false,
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
}
