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
      _ => throw const FormatException(ERROR_RESOURCE_TYPE_ITEM_PARSER),
    };
  }

  @override
  String toString() {
    return '<ResourceType> [$name] ($key)';
  }
}
