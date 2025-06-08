import 'package:ekmajstro_trejnisto/config/config.dart';
import 'package:ekmajstro_trejnisto/utils/app.dart';

import 'models.dart';

int MAX_LENGTH_RESOURCE_SPECIFICATION = 80;

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

  String parseTypeIcon() {
    return "$BACKEND_ASSETS$SUB_PATH_ASSETS_TYPE_RESOURCE$type_icon.svg";
  }
}

class Resource {
  String id;
  String name;
  String description;
  String specification;
  String type;
  String type_key;
  String file_name;
  String file_uri;
  String file_size;
  String file_mime;
  String file_extension;

  Resource({
    this.id = '',
    this.name = '',
    this.description = '',
    this.specification = '',
    this.type = '',
    this.type_key = '',
    this.file_name = '',
    this.file_uri = '',
    this.file_size = '',
    this.file_mime = '',
    this.file_extension = '',
  });

  factory Resource.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "rec_id": dynamic id,
        "rec_nombre": String name,
        "rec_descripcion": String description,
        "tp_rec_id": dynamic type_id,
        "especificaciones": {
          "espc_descripcin": String specification,
        },
        "tipos": {
          "tp_rec_diminutivo": String type_key,
        },
        "archivos": {
          "arch_uri": String file_uri,
          "arch_mime": String file_mime,
          "arch_extension": String file_extension,
          "arch_size": dynamic file_size,
          "arch_name": String file_name,
        },
      } =>
        Resource(
          id: id.toString(),
          name: name,
          description: description,
          specification: specification,
          type: type_id.toString(),
          type_key: type_key,
          file_name: file_name,
          file_uri: file_uri,
          file_size: file_size.toString(),
          file_mime: file_mime,
          file_extension: file_extension,
        ),
      {
        "id": dynamic id,
        "name": String name,
        "description": String description,
        "specification": String specification,
        "type": dynamic type_id,
        "type_key": String type_key,
        "file_name": String file_name,
        "file_uri": String file_uri,
        "file_size": String file_size,
        "file_mime": String file_mime,
        "file_extension": String file_extension,
      } =>
        Resource(
          id: id.toString(),
          name: name,
          description: description,
          specification: specification,
          type: type_id.toString(),
          type_key: type_key,
          file_name: file_name,
          file_uri: file_uri,
          file_size: file_size,
          file_mime: file_mime,
          file_extension: file_extension,
        ),
      _ => throw const FormatException(ERROR_RESOURCE_ITEM_PARSER),
    };
  }

  factory Resource.fromResource(Resource resource) {
    Resource newResource = Resource();
    newResource.copyResource(resource);
    return newResource;
  }

  void copyResource(Resource resource) {
    id = resource.id;
    name = resource.name;
    description = resource.description;
    specification = resource.specification;
    type = resource.type;
    type_key = resource.type_key;
    file_name = resource.file_name;
    file_uri = resource.file_uri;
    file_size = resource.file_size;
    file_mime = resource.file_mime;
    file_extension = resource.file_extension;
  }

  @override
  String toString() {
    return '<Resource> [$name] ($file_name, $type_key)';
  }

  String getParseSpecification() {
    if (specification.isEmpty) {
      return '';
    }

    if (specification.length > MAX_LENGTH_RESOURCE_SPECIFICATION) {
      return '${specification.substring(0, MAX_LENGTH_RESOURCE_SPECIFICATION - 3)}...';
    }

    return specification;
  }

  Map<String, dynamic> toMap(bool? forBack) {
    forBack ??= false;

    if (forBack) {
      return {
        "nombre": name,
        "descripcion": description,
        "especificacion": getParseSpecification(),
        "tipo_recurso": type,
        "archivo_uri": file_uri,
        "archivo_nombre": file_name,
        "archivo_extension": file_extension,
        "archivo_mimetismo": file_mime,
        "archivo_medida": file_size,
      };
    }

    return {
      "id": id,
      "name": name,
      "description": description,
      "specification": specification,
      "type": type,
      "type_key": type_key,
      "file_name": file_name,
      "file_uri": file_uri,
      "file_size": file_size,
      "file_mime": file_mime,
      "file_extension": file_extension,
    };
  }

  @override
  bool operator ==(Object other) {
    return (identical(this, other) ||
        (other is Resource &&
            (id == other.id &&
                name == other.name &&
                description == other.description &&
                specification == other.specification &&
                type == other.type &&
                type_key == other.type_key &&
                file_name == other.file_name &&
                file_uri == other.file_uri &&
                file_size == other.file_size &&
                file_mime == other.file_mime &&
                file_extension == other.file_extension)));
  }
}

class File {
  String name;
  String uri;
  String size;
  String extension;
  String mime_type;

  File({
    this.name = '',
    this.uri = '',
    this.size = '',
    this.extension = '',
    this.mime_type = '',
  });

  factory File.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "name": String name,
        "size": int size,
        "extension": String extension, // with dot
        "type": String type, // most of the case mime/*
      } =>
        File(
          name: name,
          uri: json['uri'] ?? '',
          size: size.toString(),
          extension: extension.startsWith('.') ? extension : '.$extension',
          mime_type: type,
        ),
      _ => throw const FormatException(ERROR_FILE_ITEM_PARSER),
    };
  }
}
