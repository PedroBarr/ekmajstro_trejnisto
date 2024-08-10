import 'package:ekmajstro_trejnisto/models/models.dart';

List<PostItem> dtoPostItemList(List<dynamic> list) {
  List<PostItem> posts = [];

  for (final postResponse in list) {
    PostItem post = PostItem.fromJson(postResponse);
    posts.add(post);
  }

  return posts;
}
