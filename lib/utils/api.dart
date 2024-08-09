import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'app.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';

const String PUBLICACIONES_ENDPOINT = '/publicaciones';

Future<List<PostItem>> getPosts() async {
  final response = await http.get(
    Uri.parse(BACKEND_API + PUBLICACIONES_ENDPOINT),
  );

  if (response.statusCode == 200) {
    late List<dynamic> body = jsonDecode(response.body);
    late List<PostItem> posts = [];

    for (final postResponse in body) {
      PostItem post = PostItem.fromJson(postResponse);
      posts.add(post);
    }

    return posts;
  } else {
    throw Exception('Fallo al cargar la lista de publicaciones');
  }
}
