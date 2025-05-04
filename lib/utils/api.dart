import 'dart:async';

import 'package:http/http.dart' as http;

import 'app.dart';
import 'dtos.dart';
import 'misc.dart';
import 'router.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';
import 'package:ekmajstro_trejnisto/config/config.dart';

const String PUBLICACIONES_ENDPOINT = '/publicaciones';
const String PUBLICACION_ENDPOINT = '/publicacion/$ROUTE_ID_WILDCARD';

Future<List<PostItem>> getPosts() async {
  try {
    final response = await http.get(
      Uri.parse(BACKEND_API + PUBLICACIONES_ENDPOINT),
    );

    late List<dynamic> body = getBody(response);
    late List<PostItem> posts = dtoPostItemList(body);
    return posts;
  } catch (e) {
    throw Exception(ERROR_POST_ITEM_LIST);
  }
}

Future<Post> getPost(String id) async {
  try {
    String subPath =
        PUBLICACION_ENDPOINT.replaceAll(ROUTE_ID_WILDCARD, id.toString());

    final response = await http.get(
      Uri.parse(BACKEND_API + subPath),
    );

    late dynamic body = getBody(response);
    late Post post = Post.fromJson(body);
    return post;
  } catch (e) {
    throw Exception(ERROR_POST_ITEM);
  }
}
