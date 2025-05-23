import 'package:ekmajstro_trejnisto/models/models.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

typedef IconSegmentTypeEntry = DropdownMenuEntry<IconSegmentType>;

enum IconSegmentType {
  text('Text', Icons.text_fields, SegmentType.text),
  image('Image', Icons.image, SegmentType.image);

  const IconSegmentType(
    this.label,
    this.icon,
    this.type,
  );
  final String label;
  final IconData icon;
  final SegmentType type;

  static final List<IconSegmentTypeEntry> entries =
      UnmodifiableListView<IconSegmentTypeEntry>(
    values.map<IconSegmentTypeEntry>(
      (IconSegmentType icon) => IconSegmentTypeEntry(
          value: icon, label: icon.label, leadingIcon: Icon(icon.icon)),
    ),
  );
}

typedef IconSegmentMeasureEntry = DropdownMenuEntry<IconSegmentMeasure>;

enum IconSegmentMeasure {
  full('Full', Icons.looks_one, SegmentMeasure.full),
  half('Half', Icons.looks_two, SegmentMeasure.half),
  third('Third', Icons.looks_3, SegmentMeasure.third);

  const IconSegmentMeasure(
    this.label,
    this.icon,
    this.measure,
  );
  final String label;
  final IconData icon;
  final SegmentMeasure measure;

  static final List<IconSegmentMeasureEntry> entries =
      UnmodifiableListView<IconSegmentMeasureEntry>(
    values.map<IconSegmentMeasureEntry>(
      (IconSegmentMeasure icon) => IconSegmentMeasureEntry(
          value: icon, label: icon.label, leadingIcon: Icon(icon.icon)),
    ),
  );
}
