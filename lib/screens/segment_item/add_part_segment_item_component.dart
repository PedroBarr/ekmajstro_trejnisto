import 'package:flutter/material.dart';

import 'segment_item_view_constants.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';
import 'package:ekmajstro_trejnisto/components/components.dart';

class AddPartSegmentItemComponent extends StatefulWidget {
  final Segment segment;
  final Function(String)? onPartAdded;

  const AddPartSegmentItemComponent({
    super.key,
    required this.segment,
    this.onPartAdded,
  });

  @override
  State<AddPartSegmentItemComponent> createState() =>
      _AddPartSegmentItemComponentState();
}

class _AddPartSegmentItemComponentState
    extends State<AddPartSegmentItemComponent> {
  String _part_name = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return DialogSimpleTextComponent(
              title: SEGMENT_LABEL_ADD_PART,
              text: '$SEGMENT_LABEL_ADD_PART_MESSAGE_BASE${getSegmentTypeText(
                widget.segment.type,
              )}',
              onConfirm: () {
                if (_part_name.isNotEmpty && mounted) {
                  widget.onPartAdded?.call(_part_name);

                  setState(() {
                    _part_name = '';
                  });

                  Navigator.of(context).pop();
                }
              },
              showField: true,
              field: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.75,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: SEGMENT_PART_LABEL_NAME,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSubmitted: (value) {
                    if (mounted) {
                      setState(() {
                        _part_name = value;
                      });
                    }
                  },
                ),
              ),
              onCancel: () {
                if (mounted) {
                  setState(() {
                    _part_name = '';
                  });
                }

                Navigator.of(context).pop();
              },
            );
          },
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 20,
        height: 50.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            style: BorderStyle.solid,
            color: Theme.of(context).colorScheme.surface,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.primary,
          size: 30.0,
        ),
      ),
    );
  }
}
