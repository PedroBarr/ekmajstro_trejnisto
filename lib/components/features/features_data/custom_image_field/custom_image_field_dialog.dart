import 'package:flutter/material.dart';

import 'package:ekmajstro_trejnisto/components/components.dart';

class CustomImageFieldDialog extends StatefulWidget {
  final String mode;
  final String? value;
  final String? title;
  final bool titleEditable;
  final Function? onEditTitle;
  final Function? onEditImage;

  const CustomImageFieldDialog({
    super.key,
    this.mode = 'edit',
    this.value,
    this.title,
    this.titleEditable = false,
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
  Widget getTitleWidget() {
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
  }

  @override
  Widget build(BuildContext context) {
    if (widget.mode == 'detail') {
      return Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 20,
          maxHeight: MediaQuery.of(context).size.height - 50,
        ),
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              widget.value!,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            getTitleWidget(),
          ],
        ),
      );
    } else {
      return Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 20,
          maxHeight: MediaQuery.of(context).size.height - 50,
        ),
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Builder(builder: (context) {
              if (widget.title != null) {
                return CustomTextFieldComponent(
                  value: widget.title!,
                  spacing: 10.0,
                  font_size: 16,
                  onConfirm: (value) {
                    if (widget.onEditTitle != null) {
                      widget.onEditTitle!(value);
                    }
                  },
                );
              }
              return const SizedBox.shrink();
            }),
            const SizedBox(height: 10),
            Builder(
              builder: (context) {
                if (widget.value != null) {
                  return Image.network(
                    widget.value!,
                    fit: BoxFit.cover,
                  );
                } else {
                  return const Icon(
                    Icons.library_add,
                    color: Colors.grey,
                  );
                }
              },
            ),
          ],
        ),
        // child: TextField(),
      );
    }
  }
}
