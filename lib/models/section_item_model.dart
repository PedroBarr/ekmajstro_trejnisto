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
      {
        'id': String id,
        'name': String name,
      } =>
        SectionItem(id: id, name: name),
      _ => throw const FormatException(ERROR_SECTION_ITEM_PARSER),
    };
  }

  @override
  String toString() {
    return '<Section> [$name]${is_mark_one ? ' <marcada>' : ''}';
  }
}

class Section {
  String id;
  String name;
  bool is_mark_one;

  Section({
    this.id = '',
    this.name = '',
    this.is_mark_one = false,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'secc_id': String id,
        'secc_nombre': String name,
        'con_seccion_marcada': int is_mark,
      } =>
        Section(id: id, name: name, is_mark_one: is_mark == 1),
      {
        'secc_id': int id,
        'secc_nombre': String name,
        'con_seccion_marcada': int is_mark,
      } =>
        Section(id: id.toString(), name: name, is_mark_one: is_mark == 1),
      {
        'secc_id': String id,
        'secc_nombre': String name,
      } =>
        Section(id: id, name: name),
      {
        'secc_id': int id,
        'secc_nombre': String name,
      } ||
      {
        'id': int id,
        'name': String name,
      } =>
        Section(id: id.toString(), name: name),
      _ => throw const FormatException(ERROR_SECTION_ITEM_PARSER),
    };
  }

  factory Section.fromSection(Section section) {
    Section newSection = Section();
    newSection.copySection(section);
    return newSection;
  }

  void copySection(Section section) {
    id = section.id;
    name = section.name;
    is_mark_one = section.is_mark_one;
  }

  @override
  String toString() {
    return '<Section> [$name]${is_mark_one ? ' <marcada>' : ''}';
  }

  Map<String, dynamic> toMap(bool include_es_marcada, bool? forBack) {
    forBack ??= false;

    Map<String, dynamic> map = {};

    if (forBack) {
      map['id'] = id;
      map['nombre'] = name;
      map['es_marcada'] = is_mark_one ? true : false;
    } else {
      map['id'] = id;
      map['name'] = name;
    }

    if (!include_es_marcada && map.containsKey('es_marcada')) {
      map.remove('es_marcada');
    }

    return map;
  }
}
