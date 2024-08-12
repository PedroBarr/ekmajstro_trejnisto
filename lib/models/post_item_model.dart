import 'dart:core';

import 'package:ekmajstro_trejnisto/config/config.dart';

import 'model_item.dart';

class PostItem extends ModelItem {
  final String title;

  const PostItem({
    required super.id,
    required this.title,
  });

  factory PostItem.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'pblc_id': String id,
        'pblc_titulo': String title,
      } =>
        PostItem(id: id, title: title),
      {
        'pblc_id': int id,
        'pblc_titulo': String title,
      } ||
      {
        'id': int id,
        'title': String title,
      } =>
        PostItem(id: id.toString(), title: title),
      _ => throw const FormatException(ERROR_POST_ITEM_PARSER),
    };
  }

  @override
  String toString() {
    return '<Post> [$title]';
  }
}

class Post {
  // Attributtes to set
  static const String POST_ATTR_TITTLE = 'title';
  static const String POST_ATTR_IMAGE = 'image_url';

  String id;
  String title;
  String image_url;
  final DateTime publishDate;
  final String user;

  Post({
    this.id = '',
    this.title = '',
    this.image_url = '',
  })  : user = 'Aref VarOdal',
        publishDate = DateTime.now();

  factory Post.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'pblc_id': String id,
        'pblc_titulo': String title,
      } =>
        Post(id: id, title: title),
      {
        'pblc_id': int id,
        'pblc_titulo': String title,
      } ||
      {
        'id': int id,
        'title': String title,
      } =>
        Post(id: id.toString(), title: title),
      _ => throw const FormatException(ERROR_POST_ITEM_PARSER),
    };
  }

  factory Post.fromPost(Post post) {
    return post;
  }

  setPost(String attr, String value) {
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
}
