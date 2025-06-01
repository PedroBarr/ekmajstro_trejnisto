import 'package:flutter/material.dart';

// Labels
const String SECTION_SEGMENTS_ADD = 'Agregar segmento';

// Messages
const String SAVE_SECTION_SUCCESS_MESSAGE = 'Sección guardada con éxito';
const String SAVE_SECTION_ERROR_MESSAGE = 'Error al guardar la sección';

const String MARK_SEGMENT_SUCCESS_MESSAGE = 'Segmento marcado con éxito';
const String MARK_SEGMENT_ERROR_MESSAGE = 'Error al marcar el segmento';

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
