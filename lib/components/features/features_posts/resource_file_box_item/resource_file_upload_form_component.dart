import 'dart:io' as io;

import 'package:flutter/material.dart';

import 'resource_file_box_constants.dart';

import 'package:ekmajstro_trejnisto/models/resource_item_model.dart';
import 'package:ekmajstro_trejnisto/components/core/core.dart';

class ResourceFileUploadFormComponent extends StatefulWidget {
  final Function(String, dynamic) onResourceChanged;

  const ResourceFileUploadFormComponent({
    super.key,
    required this.onResourceChanged,
  });

  @override
  State<ResourceFileUploadFormComponent> createState() =>
      _ResourceFileUploadFormComponentState();
}

class _ResourceFileUploadFormComponentState
    extends State<ResourceFileUploadFormComponent> {
  io.File? _file;

  void loadFile() {
    if (_file != null) {
      File file = File(
        name: _file!.path.split('/').last,
        uri: '',
        size: '',
        mime_type: '',
        extension: _file!.path.split('.').last,
      );

      widget.onResourceChanged('file', file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FilePickerComponent(
          onFilePicked: (filePath) {
            setState(() {
              _file = io.File(filePath);
            });
          },
        ),
        SizedBox(height: 10),
        Center(
          child: TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              textStyle:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Theme.of(context).colorScheme.onSurface,
              fixedSize: Size(
                MediaQuery.of(context).size.width * 0.75,
                50,
              ),
            ),
            onPressed: () {
              if (_file != null) {
                loadFile();
              }
            },
            child: const Text(
              UPLOAD_FILE_BUTTON_TEXT,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
