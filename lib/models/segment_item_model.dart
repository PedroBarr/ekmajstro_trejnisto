import 'dart:convert';

import 'models.dart';

import 'package:ekmajstro_trejnisto/config/config.dart';

enum SegmentType {
  text,
  image,
}

enum SegmentMeasure {
  full,
  half,
  third,
}

class SegmentItem extends ModelItem {
  final SegmentMeasure measure;
  final int order;
  final SegmentType type;

  const SegmentItem({
    required super.id,
    required this.measure,
    required this.order,
    required this.type,
  });

  static Map<String, SegmentMeasure> measureMap = {
    '1-col': SegmentMeasure.full,
    '2-col': SegmentMeasure.half,
    '3-col': SegmentMeasure.third,
  };

  static Map<String, SegmentType> typeMap = {
    'texto': SegmentType.text,
    'imagen': SegmentType.image,
  };

  factory SegmentItem.fromJson(Map<String, dynamic> json) {
    try {
      String id = json['id']?.toString() ?? json['segm_id'].toString();

      SegmentMeasure measure = SegmentMeasure.values.firstWhere(
        (e) => SegmentItem.measureMap[json['segm_medida']] == e,
        orElse: () => SegmentMeasure.full,
      );

      int order = json['segm_posicion'] ?? 0;

      dynamic content = jsonDecode(json['segm_contenido']);
      SegmentType type = SegmentType.values.firstWhere(
        (e) => SegmentItem.typeMap[content['tipo']] == e,
        orElse: () => SegmentType.text,
      );

      return SegmentItem(
        id: id,
        measure: measure,
        order: order,
        type: type,
      );
    } catch (e) {
      throw const FormatException(ERROR_SEGMENT_ITEM_PARSER);
    }
  }
}
