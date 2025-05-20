import 'dart:core';

import 'package:ekmajstro_trejnisto/config/config.dart';
import 'package:ekmajstro_trejnisto/utils/utils.dart';

import 'model_item.dart';

class PostItem extends ModelItem {
  final String title;
  final bool with_preview;

  const PostItem({
    required super.id,
    required this.title,
    this.with_preview = false,
  });

  factory PostItem.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'pblc_id': String id,
        'pblc_titulo': String title,
        'con_previsualizacion': int with_preview,
      } =>
        PostItem(id: id, title: title, with_preview: with_preview == 1),
      {
        'pblc_id': int id,
        'pblc_titulo': String title,
        'con_previsualizacion': int with_preview,
      } =>
        PostItem(
            id: id.toString(), title: title, with_preview: with_preview == 1),
      {
        'id': int id,
        'title': String title,
      } =>
        PostItem(id: id.toString(), title: title),
      {
        'id': String id,
        'title': String title,
      } =>
        PostItem(id: id, title: title),
      _ => throw const FormatException(ERROR_POST_ITEM_PARSER),
    };
  }

  @override
  String toString() {
    return '<Post> [$title]';
  }

  String trimTitle({int? max_length}) {
    int max_length_inner = max_length ?? 10;

    return title.length > max_length_inner
        ? "${title.substring(0, max_length_inner)}..."
        : title;
  }
}

class Post {
  // Attributtes to set
  static const String POST_ATTR_TITTLE = 'title';
  static const String POST_ATTR_IMAGE = 'image_url';

  String id;
  String title;
  String image_url;
  DateTime publish_date;
  String user;

  Post({
    this.id = '',
    this.title = '',
    this.image_url = '',
  })  : user = 'Aref VarOdal',
        publish_date = DateTime.now();

  factory Post.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'pblc_id': String id,
        'pblc_titulo': String title,
        'pblc_img_portada_uri': String image_url,
      } =>
        Post(id: id, title: title, image_url: image_url),
      {
        'pblc_id': int id,
        'pblc_titulo': String title,
        'pblc_img_portada_uri': String image_url,
      } ||
      {
        'id': int id,
        'title': String title,
        'image_url': String image_url,
      } =>
        Post(id: id.toString(), title: title, image_url: image_url),
      _ => throw const FormatException(ERROR_POST_ITEM_PARSER),
    };
  }

  factory Post.fromPost(Post post) {
    Post newPost = Post();
    newPost.copyPost(post);
    return newPost;
  }

  void copyPost(Post post) {
    id = post.id;
    title = post.title;
    image_url = post.image_url;
    user = post.user;
    publish_date = post.publish_date;
  }

  void setPost(String attr, String value) {
    switch (attr) {
      case POST_ATTR_TITTLE:
        title = value;
        break;
      case POST_ATTR_IMAGE:
        image_url = value;
        break;
      default:
        break;
    }
  }

  String getDateFormatted() {
    return '${publish_date.year}-${publish_date.month}-${publish_date.day}';
  }

  @override
  String toString() {
    return '<Post> [$title]';
  }

  @override
  bool operator ==(Object other) {
    return (identical(this, other) ||
        (other is Post &&
            runtimeType == other.runtimeType &&
            (id == other.id &&
                title == other.title &&
                image_url == other.image_url &&
                publish_date == other.publish_date &&
                user == other.user)));
  }

  Map<String, dynamic> toMap(bool? forBack) {
    forBack ??= false;

    if (forBack) {
      return {
        'id': id,
        'titulo': title,
        'imagen': image_url,
        'fecha': publish_date.toString(),
        'usuario': user,
      };
    }

    return {
      'id': id,
      'title': title,
      'image_url': image_url,
      'publish_date': publish_date,
      'user': user,
    };
  }

  String getAppLink() {
    return FRONTEND_APP + SUB_PATH_FRONTEND_PUBLICATION + id;
  }
}
