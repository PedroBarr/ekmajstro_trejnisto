import 'package:ekmajstro_trejnisto/config/config.dart';

import 'models.dart';

class PreviewItem extends ModelItem {
  String short_text;
  String long_text;
  String image_url;

  PreviewItem({
    super.id = '',
    this.short_text = '',
    this.long_text = '',
    this.image_url = '',
  });

  factory PreviewItem.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'prev_id': String id,
        'prev_resumen': String short_text,
        'prev_descripcion': String long_text,
        'prev_img_miniatura_uri': String image_url,
      } =>
        PreviewItem(
          id: id,
          short_text: short_text,
          long_text: long_text,
          image_url: image_url,
        ),
      {
        'prev_id': int id,
        'prev_resumen': String short_text,
        'prev_descripcion': String long_text,
        'prev_img_miniatura_uri': String image_url,
      } =>
        PreviewItem(
          id: id.toString(),
          short_text: short_text,
          long_text: long_text,
          image_url: image_url,
        ),
      {
        'id': int id,
        'short_text': String short_text,
        'long_text': String long_text,
        'image_url': String image_url,
      } =>
        PreviewItem(
          id: id.toString(),
          short_text: short_text,
          long_text: long_text,
          image_url: image_url,
        ),
      _ => throw const FormatException(ERROR_PREVIEW_ITEM_PARSER),
    };
  }

  @override
  String toString() {
    return '<Preview> [$short_text]';
  }

  Map<String, dynamic> toMap(bool? forBack) {
    forBack ??= false;

    if (forBack) {
      return {
        'resumen': short_text,
        'descripcion': long_text,
        'miniatura_uri': image_url,
      };
    }

    return {
      'id': id,
      'short_text': short_text,
      'long_text': long_text,
      'image_url': image_url,
    };
  }
}
