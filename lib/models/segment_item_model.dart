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

  @override
  String toString() {
    return '<Segment> [${measure.name}] [${type.name}] ($order)';
  }
}

class Segment {
  String id;
  SegmentMeasure measure;
  int order;
  SegmentType type;
  Map<String, dynamic> content;

  Segment({
    this.id = '',
    this.measure = SegmentMeasure.full,
    this.order = -1,
    this.type = SegmentType.text,
    this.content = const {},
  });

  factory Segment.fromJson(Map<String, dynamic> json) {
    try {
      String id = json['id']?.toString() ?? json['segm_id'].toString();

      SegmentMeasure measure = SegmentMeasure.values.firstWhere(
        (e) => SegmentItem.measureMap[json['segm_medida']] == e,
        orElse: () => SegmentMeasure.full,
      );

      int order = json['segm_posicion'] ?? 0;

      dynamic content = json['segm_contenido'];
      SegmentType type = SegmentType.values.firstWhere(
        (e) => SegmentItem.typeMap[content['tipo']] == e,
        orElse: () => SegmentType.text,
      );

      return Segment(
        id: id,
        measure: measure,
        order: order,
        type: type,
        content: content,
      );
    } catch (e) {
      throw const FormatException(ERROR_SEGMENT_ITEM_PARSER);
    }
  }

  @override
  String toString() {
    return '<Segment> [${measure.name}] [${type.name}] ($order)';
  }

  dynamic getContent(String key) {
    if (content.containsKey(key)) {
      return content[key];
    } else {
      return null;
    }
  }

  dynamic getMainContent() {
    return switch (type) {
      SegmentType.text || SegmentType.image => content['contenido'],
    };
  }

  dynamic getClass() {
    return getContent('clase');
  }
}
