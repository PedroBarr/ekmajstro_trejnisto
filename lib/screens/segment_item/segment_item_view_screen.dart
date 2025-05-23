import 'package:ekmajstro_trejnisto/components/core/FAB_ekmajstro/FAB_ekmajstro_component.dart';
import 'package:ekmajstro_trejnisto/screens/segment_item/segment_item_view_constants.dart';
import 'package:ekmajstro_trejnisto/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';

class SegmentItemView extends StatefulWidget {
  final int post_id;
  final int section_id;
  final int? segment_id;

  const SegmentItemView({
    super.key,
    required this.post_id,
    required this.section_id,
    this.segment_id,
  });

  @override
  State<SegmentItemView> createState() => _SegmentItemView();
}

class _SegmentItemView extends State<SegmentItemView> {
  Segment _segment = Segment();

  @override
  void initState() {
    super.initState();

    if (widget.segment_id != null && isNumeric(widget.segment_id.toString())) {
      getSegment(widget.segment_id!.toString()).then((segment) {
        setState(() {
          _segment = segment;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Builder(
              builder: (context) {
                if (_segment.id.isNotEmpty) {
                  return DropdownMenu<IconSegmentType>(
                    initialSelection: IconSegmentType.values.firstWhere(
                      (entry) => entry.type == _segment.type,
                      orElse: () => IconSegmentType.text,
                    ),
                    onSelected: (_) {},
                    dropdownMenuEntries: IconSegmentType.entries,
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
          body: Builder(
            builder: (context) {
              return _segment.id.isNotEmpty
                  ? switch (_segment.type) {
                      SegmentType.text => _buildTextSegment(),
                      SegmentType.image => _buildImageSegment(),
                    }
                  : SizedBox.shrink();
            },
          ),
        ),
        const FABEkmajstroComponent(),
      ],
    );
  }

  Widget _buildTextSegment() {
    return const Text('Text Segment');
  }

  Widget _buildImageSegment() {
    return const Text('Image Segment');
  }
}
