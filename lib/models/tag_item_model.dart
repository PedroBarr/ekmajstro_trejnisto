import 'package:ekmajstro_trejnisto/config/config.dart';

import 'models.dart';

class TagItem extends ModelItem {
  final String name;

  const TagItem({
    required super.id,
    required this.name,
  });

  factory TagItem.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'etq_id': String id,
        'etq_nombre': String name,
      } =>
        TagItem(id: id, name: name),
      {
        'etq_id': int id,
        'etq_nombre': String name,
      } =>
        TagItem(id: id.toString(), name: name),
      {
        'id': int id,
        'name': String name,
      } =>
        TagItem(id: id.toString(), name: name),
      _ => throw const FormatException(ERROR_TAG_ITEM_PARSER),
    };
  }

  @override
  String toString() {
    return '<Tag> [$name]';
  }
}

class Tag {
  final String id;
  final String name;
  final String description;

  const Tag({
    this.id = '',
    required this.name,
    this.description = '',
  });
}
