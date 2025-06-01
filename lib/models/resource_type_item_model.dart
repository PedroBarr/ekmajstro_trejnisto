import 'package:ekmajstro_trejnisto/config/config.dart';

import 'models.dart';

class ResourceTypeItem extends ModelItem {
  final String name;
  final String icon;
  final String key;

  const ResourceTypeItem({
    required super.id,
    required this.name,
    required this.icon,
    required this.key,
  });

  factory ResourceTypeItem.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'tp_rec_id': int id,
        'tp_rec_nombre': String name,
        'tp_rec_icon_url': String icon,
        'tp_rec_filter_key': String key,
      } =>
        ResourceTypeItem(id: id.toString(), name: name, icon: icon, key: key),
      {
        'tp_rec_id': String id,
        'tp_rec_nombre': String name,
        'tp_rec_icon_url': String icon,
        'tp_rec_filter_key': String key,
      } =>
        ResourceTypeItem(id: id, name: name, icon: icon, key: key),
      _ => throw const FormatException(ERROR_RESOURCE_TYPE_ITEM_PARSER),
    };
  }

  @override
  String toString() {
    return '<ResourceType> [$name] ($key)';
  }
}
