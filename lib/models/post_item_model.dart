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
        PostItem(id: int.parse(id), title: title),
      {
        'pblc_id': int id,
        'pblc_titulo': String title,
      } ||
      {
        'id': int id,
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
}

class Post extends PostItem {
  const Post({
    super.id,
    super.title = '',
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'pblc_id': String id,
        'pblc_titulo': String title,
      } =>
        Post(id: int.parse(id), title: title),
      {
        'pblc_id': int id,
        'pblc_titulo': String title,
      } ||
      {
        'id': int id,
        'title': String title,
      } =>
        Post(id: id, title: title),
      _ => throw const FormatException(ERROR_POST_ITEM_PARSER),
    };
  }
}
