import 'package:flutter/material.dart';

// Labels
const String SECTION_SEGMENTS_ADD = 'Agregar segmento';

// Messages
const String SECTION_SEGMENTS_EMPTY_MESSAGE =
    'No hay segmentos en esta sección';
const String SEGMENT_MARK_ALREADY_MESSAGE = 'Ya está marcado';

enum SegmentDirection {
  up,
  down,
}

IconData getSegmentDirectionIcon(SegmentDirection direction) {
  return switch (direction) {
    SegmentDirection.up => Icons.arrow_left,
    SegmentDirection.down => Icons.arrow_right,
  };
}

String getSegmentDirectionName(SegmentDirection direction) {
  return switch (direction) {
    SegmentDirection.up => 'up',
    SegmentDirection.down => 'down',
  };
}
