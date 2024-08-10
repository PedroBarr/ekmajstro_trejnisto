import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'app.dart';
import 'dtos.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';

const String PUBLICACIONES_ENDPOINT = '/publicaciones';

dynamic getBody(http.Response response) {
  try {
    if (response.statusCode == 200) {
      dynamic body = jsonDecode(response.body);
      return body;
    }

    throw Exception('Fallo al recuperar el cuerpo');
  } catch (e) {
    throw Exception('Fallo al recuperar el cuerpo');
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
    throw Exception('Fallo al cargar la lista de publicaciones');
  }
}
