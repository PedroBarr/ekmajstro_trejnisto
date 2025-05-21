import 'package:flutter/material.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';
import 'package:ekmajstro_trejnisto/utils/utils.dart';
import 'package:ekmajstro_trejnisto/components/components.dart';

class SectionItemView extends StatefulWidget {
  final int post_id;
  final int? section_id;

  const SectionItemView({
    super.key,
    required this.post_id,
    this.section_id,
  });

  @override
  State<SectionItemView> createState() => _SectionItemView();
}

class _SectionItemView extends State<SectionItemView> {
  Section _section = Section();
  List<SegmentItem> _segments = [];

  @override
  void initState() {
    super.initState();

    if (widget.section_id != null && isNumeric(widget.section_id!.toString())) {
      getSection(widget.section_id!.toString()).then((section) {
        setState(() {
          _section = section;
        });
      }).whenComplete(() {
        getSectionSegments(_section).then((segments) {
          segments.sort((a, b) => a.order.compareTo(b.order));

          setState(() {
            _segments = segments;
          });
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
                if (_section.name.isNotEmpty) {
                  return CustomTextFieldComponent(
                    value: _section.name,
                    spacing: 10.0,
                    font_size: 16,
                    onConfirm: (value) {},
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
          body: FlexGrid(
            children: _segments
                .map(
                  (segment) => FlexGridItem(
                    size: getFlexGridSize(segment.measure),
                    child: getContainer(segment),
                  ),
                )
                .toList(),
          ),
        ),
        const FABEkmajstroComponent(),
      ],
    );
  }

  Widget getContainer(SegmentItem segment) {
    return Container(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 5,
          right: 5,
          top: 5,
          bottom: 5,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: getColor(segment.type),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(8),
          child: Center(
            child: getIcon(segment.type),
          ),
        ),
      ),
    );
  }

  Color getColor(SegmentType type) {
    return switch (type) {
      SegmentType.text => Color.fromARGB(255, 207, 194, 152),
      SegmentType.image => const Color.fromARGB(255, 51, 46, 100),
    };
  }

  Icon getIcon(SegmentType type) {
    return switch (type) {
      SegmentType.text => const Icon(Icons.text_fields),
      SegmentType.image => const Icon(
          Icons.image,
          color: Colors.white,
        ),
    };
  }

  FlexGridSize getFlexGridSize(SegmentMeasure measure) {
    return switch (measure) {
      SegmentMeasure.full => FlexGridSize.full,
      SegmentMeasure.half => FlexGridSize.half,
      SegmentMeasure.third => FlexGridSize.third,
    };
  }
}
