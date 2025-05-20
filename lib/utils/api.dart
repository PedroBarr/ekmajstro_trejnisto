import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'app.dart';
import 'dtos.dart';
import 'misc.dart';
import 'router.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';
import 'package:ekmajstro_trejnisto/config/config.dart';

const String PUBLICACIONES_ENDPOINT = '/publicaciones';
const String PUBLICACION_ENDPOINT = '/publicacion/$ROUTE_ID_WILDCARD';
const String PUBLICACION_NUEVA_ENDPOINT = '/publicacion';

const String SECCIONES_PUBLICACION_ENDPOINT =
    '/publicacion/$ROUTE_ID_WILDCARD/secciones';

const String RECURSOS_PUBLICACION_ENDPOINT =
    '/publicacion/$ROUTE_ID_WILDCARD/recursos';

const String ETIQUETAS_PUBLICACION_ENDPOINT =
    '/publicacion/$ROUTE_ID_WILDCARD/etiquetas';

Future<List<PostItem>> getPosts({bool? with_preview}) async {
  try {
    final query_params = {
      'con_previsualizacion': (with_preview ?? false).toString(),
    };

    final response = await http.get(
      Uri.parse(BACKEND_API + PUBLICACIONES_ENDPOINT)
          .replace(queryParameters: query_params),
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

Future<Post> savePost(Post post) async {
  if (post.id.isNotEmpty) {
    return updatePost(post);
  } else {
    return createPost(post);
  }
}

Future<Post> updatePost(Post post) async {
  try {
    String subPath =
        PUBLICACION_ENDPOINT.replaceAll(ROUTE_ID_WILDCARD, post.id);

    final response = await http.put(
      Uri.parse(BACKEND_API + subPath),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(post.toMap(true)),
    );

    late dynamic body = getBody(response);
    late Post new_post = Post.fromJson(body);

    return new_post;
  } catch (e) {
    throw Exception(ERROR_POST_ITEM);
  }
}

Future<Post> createPost(Post post) async {
  try {
    String subPath = PUBLICACION_NUEVA_ENDPOINT;

    final response = await http.post(
      Uri.parse(BACKEND_API + subPath),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(post.toMap(true)),
    );

    late dynamic body = getBody(response);
    late Post new_post = Post.fromJson(body);

    return new_post;
  } catch (e) {
    throw Exception(ERROR_POST_ITEM);
  }
}

Future<List<SectionItem>> getPostSections(Post post) async {
  try {
    String subPath =
        SECCIONES_PUBLICACION_ENDPOINT.replaceAll(ROUTE_ID_WILDCARD, post.id);

    final response = await http.get(
      Uri.parse(BACKEND_API + subPath),
    );

    late List<dynamic> body = getBody(response);
    late List<SectionItem> sections = dtoSectionItemList(body);

    return sections;
  } catch (e) {
    throw Exception(ERROR_SECTION_ITEM_LIST);
  }
}

Future<List<ResourceItem>> getPostResources(Post post) async {
  try {
    String subPath =
        RECURSOS_PUBLICACION_ENDPOINT.replaceAll(ROUTE_ID_WILDCARD, post.id);

    final response = await http.get(
      Uri.parse(BACKEND_API + subPath),
    );

    late List<dynamic> body = getBody(response);
    late List<ResourceItem> resources = dtoResourceItemList(body);

    return resources;
  } catch (e) {
    throw Exception(ERROR_RESOURCE_ITEM_LIST);
  }
}

Future<List<TagItem>> getPostTags(Post post) async {
  try {
    String subPath =
        ETIQUETAS_PUBLICACION_ENDPOINT.replaceAll(ROUTE_ID_WILDCARD, post.id);

    final response = await http.get(
      Uri.parse(BACKEND_API + subPath),
    );

    late List<dynamic> body = getBody(response);
    late List<TagItem> tags = dtoTagItemList(body);

    return tags;
  } catch (e) {
    throw Exception(ERROR_TAG_ITEM_LIST);
  }
}
