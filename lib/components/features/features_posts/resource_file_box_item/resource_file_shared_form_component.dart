import 'package:flutter/material.dart';

import 'resource_file_box_constants.dart';

class ResourceFileSharedFormComponent extends StatefulWidget {
  final Function(String, dynamic) onSharedResourceChanged;

  const ResourceFileSharedFormComponent({
    super.key,
    required this.onSharedResourceChanged,
  });

  @override
  State<ResourceFileSharedFormComponent> createState() =>
      _ResourceFileSharedFormComponentState();
}

class _ResourceFileSharedFormComponentState
    extends State<ResourceFileSharedFormComponent> {
  final TextEditingController _sharedIdController = TextEditingController();

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
              SHARED_KEY_LABEL,
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
                  labelText: SHARED_KEY_HINT,
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
                onSubmitted: (value) {},
                controller: _sharedIdController,
                onChanged: (value) => _sharedIdController.text = value,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
