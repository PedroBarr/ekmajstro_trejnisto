import 'package:flutter/material.dart';

import 'resource_file_box_constants.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';

class ResourceFileFormComponent extends StatefulWidget {
  final Resource resource;
  final Function(String, dynamic) onResourceChanged;

  const ResourceFileFormComponent({
    super.key,
    required this.resource,
    required this.onResourceChanged,
  });

  @override
  State<ResourceFileFormComponent> createState() =>
      _ResourceFileFormComponentState();
}

class _ResourceFileFormComponentState extends State<ResourceFileFormComponent> {
  void setResource(String key, dynamic value) {
    widget.onResourceChanged(key, value);
  }

  @override
  Widget build(BuildContext context) {
    double widthFileFields = MediaQuery.of(context).size.width * 0.6;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              FILE_NAME_LABEL,
              style: TextStyle(
                fontSize: 16.0,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            Container(
              constraints: BoxConstraints(
                maxWidth: widthFileFields,
              ),
              child: TextField(
                decoration: InputDecoration(
                  labelText: FILE_NAME_HINT,
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 12,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                onSubmitted: (value) {
                  setResource('file_name', value);
                },
                controller: TextEditingController(
                  text: widget.resource.file_name,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              FILE_URI_LABEL,
              style: TextStyle(
                fontSize: 16.0,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            Container(
              constraints: BoxConstraints(
                maxWidth: widthFileFields,
              ),
              child: TextField(
                decoration: InputDecoration(
                  labelText: FILE_URI_HINT,
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 12,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                onSubmitted: (value) {
                  setResource('file_uri', value);
                },
                controller: TextEditingController(
                  text: widget.resource.file_uri,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              FILE_SIZE_LABEL,
              style: TextStyle(
                fontSize: 16.0,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            Container(
              constraints: BoxConstraints(
                maxWidth: widthFileFields,
              ),
              child: TextField(
                decoration: InputDecoration(
                  labelText: FILE_SIZE_HINT,
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 12,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  suffix: Text(
                    FILE_SIZE_UNIT_LABEL,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                keyboardType: TextInputType.number,
                onSubmitted: (value) {
                  setResource('file_size', value);
                },
                controller: TextEditingController(
                  text: widget.resource.file_size,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              FILE_MIME_LABEL,
              style: TextStyle(
                fontSize: 16.0,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            Container(
              constraints: BoxConstraints(
                maxWidth: widthFileFields,
              ),
              child: TextField(
                decoration: InputDecoration(
                  labelText: FILE_MIME_HINT,
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 12,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                onSubmitted: (value) {
                  setResource('file_mime', value);
                },
                controller: TextEditingController(
                  text: widget.resource.file_mime,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              FILE_EXTENSION_LABEL,
              style: TextStyle(
                fontSize: 16.0,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            Container(
              constraints: BoxConstraints(
                maxWidth: widthFileFields,
              ),
              child: TextField(
                decoration: InputDecoration(
                  labelText: FILE_EXTENSION_HINT,
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 12,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                onSubmitted: (value) {
                  setResource('file_extension', value);
                },
                controller: TextEditingController(
                  text: widget.resource.file_extension,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
