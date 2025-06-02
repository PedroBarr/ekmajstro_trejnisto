import 'package:flutter/material.dart';

import 'dialog_action_options_constants.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';
import 'package:ekmajstro_trejnisto/components/core/dialog_simple_text/dialog_simple_text.dart';

class DialogActionOptionsComponent extends StatefulWidget {
  final List<ActionItemModel> actions;
  final String title;
  final String text;

  const DialogActionOptionsComponent({
    super.key,
    required this.actions,
    this.title = DIALOG_ACTION_OPTIONS_TITLE,
    this.text = DIALOG_ACTION_OPTIONS_TEXT,
  });

  @override
  State<DialogActionOptionsComponent> createState() =>
      _DialogActionOptionsComponentState();
}

class _DialogActionOptionsComponentState
    extends State<DialogActionOptionsComponent> {
  @override
  Widget build(BuildContext context) {
    return DialogSimpleTextComponent(
      title: widget.title,
      text: widget.text,
      confirmText: DIALOG_ACTION_OPTIONS_CANCEL,
      onConfirm: () => Navigator.of(context).pop(),
      showCancel: false,
      showField: true,
      field: Column(
        mainAxisSize: MainAxisSize.min,
        children: widget.actions.map((action) {
          return GestureDetector(
            onTap: () {
              action.onTap?.call();
              Navigator.of(context).pop();
            },
            child: Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              decoration: BoxDecoration(
                color: action.backColor ??
                    Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              width: MediaQuery.of(context).size.width,
              child: Row(
                spacing: 10.0,
                children: [
                  if (action.icon != null)
                    Icon(
                      action.icon,
                      color: action.color ??
                          Theme.of(context).colorScheme.onSurface,
                    ),
                  Text(
                    action.label,
                    style: TextStyle(
                      color: action.color ??
                          Theme.of(context).colorScheme.onSurface,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.fontFamily,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
