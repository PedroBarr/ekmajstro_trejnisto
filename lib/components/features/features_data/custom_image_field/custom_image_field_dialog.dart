import 'package:flutter/material.dart';

class CustomImageFieldDialog extends StatefulWidget {
  final String mode;
  final String? value;
  final String? title;

  const CustomImageFieldDialog({
    super.key,
    this.mode = 'edit',
    this.value,
    this.title,
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
    if (widget.mode == 'edit') {
      return Container();
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
            Image.network(
              widget.value!,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            getTitleWidget(),
          ],
        ),
      );
    }
  }
}
