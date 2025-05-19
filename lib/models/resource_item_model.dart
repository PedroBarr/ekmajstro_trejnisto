import 'package:ekmajstro_trejnisto/config/config.dart';

import 'models.dart';

class ResourceItem extends ModelItem {
  final String name;
  final String description;
  final String type;
  final String type_icon;
  final String specification;

  const ResourceItem({
    required super.id,
    required this.name,
    this.description = '',
    required this.type,
    required this.type_icon,
    this.specification = '',
  });

  factory ResourceItem.fromJson(Map<String, dynamic> json) {
    if ((json.containsKey('id') ||
            (json.containsKey('rec_id') &&
                (json['rec_id'] is String || json['rec_id'] is int))) &&
        (json.containsKey('type') ||
            (json.containsKey('tipos') &&
                json['tipos'] is Map<String, dynamic> &&
                json['tipos'].containsKey('tp_rec_nombre'))) &&
        (json.containsKey('type_icon') ||
            (json.containsKey('tipos') &&
                json['tipos'] is Map<String, dynamic> &&
                json['tipos'].containsKey('tp_rec_diminutivo'))) &&
        (json.containsKey('name') ||
            (json.containsKey('rec_nombre') && json['rec_nombre'] is String))) {
      String description = '';

      if (json.containsKey('description') ||
          json.containsKey('rec_descripcion')) {
        description = json['description'] ?? json['rec_descripcion'];
      }

      String specification = '';

      if (json.containsKey('specification') ||
          (json.containsKey('especificaciones') &&
              json['especificaciones'] is Map<String, dynamic> &&
              json['especificaciones'].containsKey('espc_descripcin'))) {
        specification = json['specification'] ??
            json['especificaciones']['espc_descripcin'];
      }

      return ResourceItem(
        id: json['id']?.toString() ?? json['rec_id'].toString(),
        name: json['name'] ?? json['rec_nombre'],
        type: json['type'] ?? json['tipos']['tp_rec_nombre'],
        type_icon: json['type_icon'] ?? json['tipos']['tp_rec_diminutivo'],
        description: description,
        specification: specification,
      );
    } else {
      throw const FormatException(ERROR_RESOURCE_ITEM_PARSER);
    }
  }

  @override
  String toString() {
    String type_line = '<:>';

    if (type.isNotEmpty) {
      type_line = type_line.replaceAll('<', '<$type');
    }

    if (specification.isNotEmpty) {
      type_line = type_line.replaceAll('>', '$specification>');
    }

    type_line = type_line.replaceAll(':>', '>');
    type_line = type_line.replaceAll('<:', '<');

    if (type_line == '<>') {
      type_line = ' ';
    } else {
      type_line = ' $type_line';
    }

    return '<Resource> [$name]$type_line';
  }
}
