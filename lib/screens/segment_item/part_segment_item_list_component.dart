import 'package:flutter/material.dart';

import 'segment_item_view_constants.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';

class PartSegmentItemListComponent extends StatefulWidget {
  final Segment segment;
  final Function(String, dynamic)? onPartModified;

  const PartSegmentItemListComponent({
    super.key,
    required this.segment,
    this.onPartModified,
  });

  @override
  State<PartSegmentItemListComponent> createState() =>
      _PartSegmentItemListComponentState();
}

class _PartSegmentItemListComponentState
    extends State<PartSegmentItemListComponent> {
  @override
  Widget build(BuildContext context) {
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
                width: MediaQuery.of(context).size.width / 2,
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width / 2,
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
