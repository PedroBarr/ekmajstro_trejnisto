import 'package:flutter/material.dart';

import 'segment_item_view_constants.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';

class PartSegmentItemListComponent extends StatefulWidget {
  final Segment segment;
  final Function(String, dynamic)? onPartModified;
  final double? value_part_width;

  const PartSegmentItemListComponent({
    super.key,
    required this.segment,
    this.onPartModified,
    this.value_part_width,
  });

  @override
  State<PartSegmentItemListComponent> createState() =>
      _PartSegmentItemListComponentState();
}

class _PartSegmentItemListComponentState
    extends State<PartSegmentItemListComponent> {
  @override
  Widget build(BuildContext context) {
    double value_part_width =
        widget.value_part_width ?? MediaQuery.of(context).size.width / 2;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        getContentKeys().length,
        (index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(getContentKeys()[index]),
              Container(
                width: value_part_width,
                constraints: BoxConstraints(
                  maxWidth: value_part_width,
                ),
                padding: const EdgeInsets.only(
                  top: 5.0,
                  bottom: 5.0,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: SEGMENT_LABEL_CONTENT,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  controller: TextEditingController(
                    text: widget.segment.getContent(getContentKeys()[index]),
                  ),
                  onSubmitted: (value) {
                    widget.onPartModified?.call(
                      getContentKeys()[index],
                      value,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  List<String> getContentKeys() {
    return widget.segment.content.keys
        .where((key) => !defaultParts.contains(key))
        .toList();
  }
}
