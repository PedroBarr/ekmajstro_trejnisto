import 'package:flutter/material.dart';

import 'package:ekmajstro_trejnisto/components/components.dart';

class CustomImageFieldDialog extends StatefulWidget {
  final String mode;
  final String? value;
  final String? title;
  final bool is_title_editable;
  final Function? onEditTitle;
  final Function? onEditImage;

  const CustomImageFieldDialog({
    super.key,
    this.mode = 'edit',
    this.value,
    this.title,
    this.is_title_editable = false,
    this.onEditTitle,
    this.onEditImage,
  })  : assert(
          mode == 'edit' || mode == 'detail',
          'mode must be either "edit" or "detail"',
        ),
        assert(
          (mode == 'detail' && value != null) || mode == 'edit',
          'value must be provided when mode is "detail"',
        );

  @override
  State<CustomImageFieldDialog> createState() => _CustomImageFieldDialog();
}

class _CustomImageFieldDialog extends State<CustomImageFieldDialog> {
  @override
  Widget build(BuildContext context) {
    if (widget.mode == 'detail') {
      return Container(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width - 20,
                  maxHeight: MediaQuery.of(context).size.height - 50,
                ),
                padding: const EdgeInsets.all(10.0),
                child: Image.network(
                  widget.value!,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 10),
              Builder(
                builder: (context) {
                  if (widget.title != null) {
                    return Text(
                      widget.title!,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                        decoration: TextDecoration.none,
                        fontFamily: 'Roboto',
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Builder(builder: (context) {
                if (widget.title != null) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    padding: const EdgeInsets.all(10.0),
                    alignment: Alignment.center,
                    child: CustomTextFieldComponent(
                      value: widget.title!,
                      spacing: 10.0,
                      font_size: 16,
                      onConfirm: (value) {
                        if (widget.onEditTitle != null) {
                          widget.onEditTitle!(value);
                        }
                      },
                      is_editable: widget.is_title_editable,
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width - 20,
                  maxHeight: MediaQuery.of(context).size.height - 50,
                ),
                padding: const EdgeInsets.all(10.0),
                child: Builder(
                  builder: (context) {
                    if (widget.value != null) {
                      return Image.network(
                        widget.value!,
                        fit: BoxFit.cover,
                      );
                    } else {
                      return Icon(
                        Icons.library_add,
                        color: Theme.of(context).colorScheme.onSurface,
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.8,
                      maxHeight: 50,
                    ),
                    height: 50,
                    // width: MediaQuery.of(context).size.width * 0.7,
                    child: Material(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Image URL',
                          labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          if (widget.onEditImage != null) {
                            // widget.onEditImage!(value);
                          }
                        },
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    onPressed: () {
                      if (widget.onEditImage != null) {
                        // widget.onEditImage!(null);
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  if (widget.onEditImage != null) {
                    widget.onEditImage!();
                  }
                },
                child: Text(
                  'Update Image',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
