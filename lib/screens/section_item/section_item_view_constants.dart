import 'package:flutter/material.dart';

const String section_segments_add = 'Agregar segmento';
const String section_segments_empty = 'No hay segmentos en esta sección';
const String segment_mark_already = 'Ya está marcado';

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
