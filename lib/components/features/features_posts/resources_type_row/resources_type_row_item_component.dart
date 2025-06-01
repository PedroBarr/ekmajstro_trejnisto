import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'resources_type_row_constants.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';

class ResourceTypeRowItemComponent extends StatefulWidget {
  final ResourceTypeItem resource_type;
  final bool is_selected;
  final Function(ResourceTypeItem)? onTap;
  final double icon_size;

  const ResourceTypeRowItemComponent({
    super.key,
    required this.resource_type,
    this.is_selected = false,
    this.onTap,
    this.icon_size = DEFAULT_ICON_SIZE,
  });

  @override
  State<ResourceTypeRowItemComponent> createState() =>
      _ResourceTypeRowItemComponentState();
}

class _ResourceTypeRowItemComponentState
    extends State<ResourceTypeRowItemComponent> {
  static double _INNER_PADDING = 1.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(_INNER_PADDING),
      decoration: BoxDecoration(
        color: widget.is_selected
            ? Theme.of(context).colorScheme.onSurface
            : Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(50.0),
      ),
      width: widget.icon_size,
      height: widget.icon_size,
      child: IconButton(
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        tooltip: widget.resource_type.name,
        icon: widget.resource_type.icon.isNotEmpty
            ? SvgPicture.network(
                widget.resource_type.icon,
                width: widget.icon_size - _INNER_PADDING * 2,
                height: widget.icon_size - _INNER_PADDING * 2,
                placeholderBuilder: (context) => const Icon(Icons.folder),
              )
            : Icon(Icons.folder, size: widget.icon_size - _INNER_PADDING * 2),
        onPressed: () {
          if (widget.onTap != null) {
            widget.onTap!(widget.resource_type);
          }
        },
      ),
    );
  }
}
