import 'package:ekmajstro_trejnisto/models/models.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

// Field labels
const String SEGMENT_LABEL_POSITION = 'Posición';
const String SEGMENT_LABEL_MEASURE = 'Medida';
const String SEGMENT_LABEL_CLASS = 'Clase';
const String SEGMENT_LABEL_CONTENT = 'Contenido';

const String SEGMENT_LABEL_ADD_PART = 'Agregar parte';
const String SEGMENT_PART_LABEL_NAME = 'Nombre de la parte';

const String SEGMENT_CONTENT_LABEL_TEXT_TYPE = 'Texto';
const String SEGMENT_CONTENT_LABEL_IMAGE_TYPE = 'Imagen';

// Messages
const String SEGMENT_SAVE_SUCCESS_MESSAGE = 'Segmento guardado correctamente';
const String SEGMENT_SAVE_ERROR_MESSAGE = 'Error al guardar el segmento';

const String SEGMENT_POSITION_ERROR_MESSAGE = 'Sin asignar';
const String SEGMENT_LABEL_ADD_PART_MESSAGE_BASE =
    'Agregar nueva parte al segmento de tipo ';

// Dropdowns constants and enums
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

String getTextType(IconSegmentType type) {
  return switch (type) {
    IconSegmentType.text => 'texto',
    IconSegmentType.image => 'imagen',
  };
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
