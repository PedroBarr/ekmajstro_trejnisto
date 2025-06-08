import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import 'file_picker_constants.dart';

class FilePickerComponent extends StatefulWidget {
  final Function(String) onFilePicked;

  const FilePickerComponent({
    super.key,
    required this.onFilePicked,
  });

  @override
  State<FilePickerComponent> createState() => _FilePickerComponentState();
}

class _FilePickerComponentState extends State<FilePickerComponent> {
  String? _filePath;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _filePath = result.files.single.path;
      });
      widget.onFilePicked(_filePath!);
    }
  }

  String getFileName() {
    String file_name = _filePath ?? '';

    if (_filePath != null) {
      file_name = _filePath!.split('/').last;
    }

    if (file_name.isNotEmpty &&
        file_name.length > FILE_PICKER_MAX_FILENAME_LENGTH) {
      file_name =
          file_name.substring(0, FILE_PICKER_MAX_FILENAME_LENGTH - 3) + '...';
    }

    if (file_name.isNotEmpty) {
      return '$FILE_PICKER_SELECTED$file_name';
    }

    return FILE_PICKER_NOT_SELECTED;
  }

  @override
  Widget build(BuildContext context) {
    double widthFileFields = MediaQuery.of(context).size.width * 0.5;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        (_filePath != null)
            ? Container(
                constraints: BoxConstraints(
                  maxWidth: widthFileFields,
                ),
                child: Text(
                  getFileName(),
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              )
            : const Text(
                FILE_PICKER_NOT_SELECTED,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
              ),
        const SizedBox(height: 16.0),
        TextButton(
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
          ),
          onPressed: _pickFile,
          child: const Text(
            FILE_PICKER_BUTTON_TEXT,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
