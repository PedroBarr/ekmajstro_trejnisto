import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;

import 'app.dart';
import 'dtos.dart';
import 'router.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';
import 'package:ekmajstro_trejnisto/config/config.dart';

const String PUBLICACIONES_ENDPOINT = '/publicaciones';
const String PUBLICACION_ENDPOINT = '/publicacion/$ROUTE_ID_WILDCARD';

dynamic getBody(http.Response response) {
  try {
    if (response.statusCode == 200) {
      dynamic body = jsonDecode(response.body);
      return body;
    }

    throw Exception(ERROR_BODY);
  } catch (e) {
    throw Exception(ERROR_BODY);
  }
}

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

Future<Post> getPost(int id) async {
  try {
    String sub_path =
        PUBLICACION_ENDPOINT.replaceAll(ROUTE_ID_WILDCARD, id.toString());

    final response = await http.get(
      Uri.parse(BACKEND_API + sub_path),
    );

    late dynamic body = getBody(response);
    late Post post = Post.fromJson(body);
    return post;
  } catch (e) {
    throw Exception(ERROR_POST_ITEM);
  }
}
