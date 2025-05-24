import 'package:flutter/material.dart';

class DialogSimpleTextComponent extends StatefulWidget {
  final String title;
  final String text;
  final String? confirmText;
  final String? cancelText;
  final Function()? onConfirm;
  final Function()? onCancel;
  final bool? showCancel;
  final bool? showField;
  final Widget? field;

  const DialogSimpleTextComponent({
    super.key,
    required this.title,
    required this.text,
    this.confirmText = 'Aceptar',
    this.cancelText = 'Cancelar',
    this.onConfirm,
    this.onCancel,
    this.showCancel = true,
    this.showField = false,
    this.field = const SizedBox(),
  }) : assert(
          showField == true ? field != null : true,
          'Field must be provided if showField is true.',
        );

  @override
  State<DialogSimpleTextComponent> createState() =>
      _DialogSimpleTextComponentState();
}

class _DialogSimpleTextComponentState extends State<DialogSimpleTextComponent> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(
        widget.title,
        textAlign: TextAlign.start,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.text),
          if (widget.showField!) widget.field! else const SizedBox.shrink(),
        ],
      ),
      actions: [
        if (widget.showCancel!)
          TextButton(
            onPressed: widget.onCancel,
            child: Text(widget.cancelText!),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.onSurface,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
        TextButton(
          onPressed: widget.onConfirm,
          child: Text(widget.confirmText!),
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.onSurface,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
      ],
    );
  }
}
