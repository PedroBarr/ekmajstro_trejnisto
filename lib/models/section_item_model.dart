import 'package:ekmajstro_trejnisto/config/config.dart';

import 'models.dart';

class SectionItem extends ModelItem {
  final String name;
  final bool is_mark_one;

  const SectionItem({
    required super.id,
    required this.name,
    this.is_mark_one = false,
  });

  factory SectionItem.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'secc_id': String id,
        'secc_nombre': String name,
        'secciones_marcadas_exists': bool is_mark,
      } =>
        SectionItem(id: id, name: name, is_mark_one: is_mark),
      {
        'secc_id': int id,
        'secc_nombre': String name,
        'secciones_marcadas_exists': bool is_mark,
      } =>
        SectionItem(id: id.toString(), name: name, is_mark_one: is_mark),
      {
        'id': int id,
        'name': String name,
      } =>
        SectionItem(id: id.toString(), name: name),
      _ => throw const FormatException(ERROR_SECTION_ITEM_PARSER),
    };
  }
}
