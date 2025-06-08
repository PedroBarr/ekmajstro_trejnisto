import 'package:flutter/material.dart';

import 'resource_item_view_constants.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';
import 'package:ekmajstro_trejnisto/components/components.dart';

class ResourceItemFileModeBoxComponent extends StatefulWidget {
  final Resource resource;
  final Function(String, dynamic) onResourceChanged;
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
    return Padding(
      padding: EdgeInsets.only(bottom: 35.0),
      child: AccordionComponent(
        elements: [
          AccordionElement(
            name: RESOURCE_FILE_FORM_TITLE.toUpperCase(),
            content: Padding(
              padding: EdgeInsets.all(15.0),
              child: ResourceFileFormComponent(
                resource: widget.resource,
                onResourceChanged: widget.onResourceChanged,
              ),
            ),
          ),
          AccordionElement(
            name: RESOURCE_FILE_SHARED_FB_TITLE.toUpperCase(),
            content: Padding(
              padding: EdgeInsets.all(15.0),
              child: ResourceFileSharedFormComponent(
                onSharedResourceChanged: widget.onResourceChanged,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildEditMode() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: Theme.of(context).colorScheme.onPrimary,
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.1),
            blurRadius: 5.0,
            offset: Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            RESOURCE_FILE_FORM_TITLE.toUpperCase(),
            style: TextStyle(
              fontSize: 20.0,
              color: Theme.of(context).colorScheme.onPrimary,
              letterSpacing: 5.0,
              fontWeight: FontWeight.bold,
              decorationThickness: 2.0,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          ResourceFileFormComponent(
            resource: widget.resource,
            onResourceChanged: widget.onResourceChanged,
          ),
        ],
      ),
    );
  }
}
