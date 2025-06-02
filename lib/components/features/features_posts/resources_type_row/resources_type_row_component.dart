import 'package:ekmajstro_trejnisto/utils/api.dart';
import 'package:flutter/material.dart';

import 'resources_type_row_item_component.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';

class ResourcesTypeRowComponent extends StatefulWidget {
  final List<ResourceTypeItem>? selected_resources_type;
  final Function(ResourceTypeItem)? onSelect;
  final Function(ResourceTypeItem)? onUnselect;

  const ResourcesTypeRowComponent({
    super.key,
    this.selected_resources_type,
    this.onSelect,
    this.onUnselect,
  });

  @override
  State<ResourcesTypeRowComponent> createState() =>
      _ResourcesTypeRowComponent();
}

class _ResourcesTypeRowComponent extends State<ResourcesTypeRowComponent> {
  List<ResourceTypeItem> _resources_type = [];

  @override
  void initState() {
    super.initState();
    loadResourcesType();
  }

  void loadResourcesType() {
    getResourceTypes().then((types) {
      if (!mounted) return;
      setState(() {
        _resources_type = types;
      });
    });
  }

  void onTap(ResourceTypeItem item) {
    if (widget.selected_resources_type
            ?.any((selected) => selected.id == item.id) ??
        false) {
      widget.onUnselect?.call(item);
    } else {
      widget.onSelect?.call(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          spacing: 5.0,
          children: getSortedResourcesType().map((resource_type) {
            return ResourceTypeRowItemComponent(
              resource_type: resource_type,
              is_selected: widget.selected_resources_type
                      ?.any((item) => item.id == resource_type.id) ??
                  false,
              onTap: onTap,
            );
          }).toList(),
        ),
      ),
    );
  }

  List<ResourceTypeItem> getSortedResourcesType() {
    List<ResourceTypeItem> resources_type = _resources_type.toList();

    if (widget.selected_resources_type != null) {
      resources_type = [
        ...widget.selected_resources_type!,
        ...resources_type.where(
          (item) => !widget.selected_resources_type!.any(
            (selected) => selected.id == item.id,
          ),
        ),
      ];
    }

    return resources_type;
  }
}
