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

List<String> defaultParts = [
  'contenido',
  'tipo',
  'clase',
];

String getSegmentTypeText(SegmentType type) {
  switch (type) {
    case SegmentType.text:
      return 'texto';
    case SegmentType.image:
      return 'imagen';
  }
}

String getSegmentMeasureText(SegmentMeasure measure) {
  switch (measure) {
    case SegmentMeasure.full:
      return '1-col';
    case SegmentMeasure.half:
      return '2-col';
    case SegmentMeasure.third:
      return '3-col';
  }
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

  factory Segment.fromSegment(Segment segment) {
    Segment newSegment = Segment();
    newSegment.copySegment(segment);
    return newSegment;
  }

  void copySegment(Segment segment) {
    id = segment.id;
    measure = segment.measure;
    order = segment.order;
    type = segment.type;
    content = jsonDecode(jsonEncode(segment.content));
  }

  void setSegment(String attr, dynamic value) {
    switch (attr) {
      case 'measure':
      case 'medida':
        if (value is SegmentMeasure) {
          measure = value;
        } else {
          measure = SegmentMeasure.values.firstWhere(
            (e) => SegmentItem.measureMap[value] == e,
            orElse: () => SegmentMeasure.full,
          );
        }
        break;
      case 'order':
      case 'posicion':
        order = value;
        break;
      case 'type':
      case 'tipo':
        content = jsonDecode('{"tipo": "$value"}');

        type = SegmentType.values.firstWhere(
          (e) => SegmentItem.typeMap[value] == e,
          orElse: () => SegmentType.text,
        );
        break;
      case 'main_content':
      case 'contenido_principal':
        setContent('contenido', value);
        break;
      case 'content':
      case 'contenido':
        content = jsonDecode(value);
        break;
      default:
        setContent(attr, value);
        break;
    }
  }

  void setContent(String key, dynamic value) {
    Map<String, dynamic> newContent = jsonDecode(jsonEncode(content));
    newContent[key] = value;
    content = newContent;
  }

  @override
  String toString() {
    return '<Segment> [${measure.name}] [${type.name}] ($order)';
  }

  @override
  bool operator ==(Object other) {
    return (identical(this, other) ||
        (other is Segment &&
            runtimeType == other.runtimeType &&
            (id == other.id &&
                measure == other.measure &&
                order == other.order &&
                type == other.type &&
                content.toString() == other.content.toString())));
  }

  Map<String, dynamic> toMap(bool include_posicion, bool? forBack) {
    forBack ??= false;

    Map<String, dynamic> map = {};

    if (forBack) {
      map['id'] = id;
      map['medida'] = getSegmentMeasureText(measure);
      map['posicion'] = order;
      map['contenido'] = content;

      if (!map['contenido'].containsKey('tipo')) {
        map['contenido']['tipo'] = getSegmentTypeText(type);
      }
    } else {
      map['id'] = id;
      map['segm_medida'] = measure.name;
      map['segm_posicion'] = order;
      map['segm_tipo'] = type.name;
      map['segm_contenido'] = jsonEncode(content);
    }

    if (!include_posicion) {
      if (forBack) {
        if (map.containsKey('posicion')) {
          map.remove('posicion');
        }
      } else {
        if (map.containsKey('segm_posicion')) {
          map.remove('segm_posicion');
        }
      }
    }

    return map;
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
      SegmentType.text || SegmentType.image => content['contenido'] ?? '',
    };
  }

  dynamic getClass() {
    return getContent('clase');
  }

  void addPart(String part) {
    if (!content.keys.toList().contains(part)) {
      content[part] = '';
    }
  }
}
