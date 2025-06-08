import 'package:flutter/material.dart';

import 'resource_item_view_constants.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';

class ResourceItemFileModeBoxComponent extends StatefulWidget {
  final Resource resource;
  final Function(Resource) onResourceChanged;
  final ResourceFileBoxMode mode;

  const ResourceItemFileModeBoxComponent({
    super.key,
    required this.resource,
    required this.onResourceChanged,
    required this.mode,
  });

  @override
  State<ResourceItemFileModeBoxComponent> createState() =>
      _ResourceItemFileModeBoxComponentState();
}

class _ResourceItemFileModeBoxComponentState
    extends State<ResourceItemFileModeBoxComponent> {
  @override
  Widget build(BuildContext context) {
    return switch (widget.mode) {
      ResourceFileBoxMode.create => _buildCreateMode(),
      ResourceFileBoxMode.edit => _buildEditMode(),
      _ => SizedBox.shrink()
    };
  }

  Widget _buildCreateMode() {
    return Text('Create Mode');
  }

  Widget _buildEditMode() {
    return Text('Edit Mode');
  }
}
