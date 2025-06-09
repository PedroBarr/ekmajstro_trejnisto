import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'app.dart';
import 'misc.dart';
import 'auth.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';
import 'package:ekmajstro_trejnisto/config/config.dart';

const String LOGIN_ENDPOINT = '/login';
const String RECURSO_PUBLICO_ENDPOINT = '/public/share/';
const String ARCHIVO_NUEVO_ENDPOINT = '/resources';
const String BUSQUEDA_ENDPOINT = '/search';

const Map<String, String> UPLOAD_QUERY_PARAMS = {
  'override': 'false',
};

Future<String> getFBAToken() async {
  try {
    final response = await http.post(
      Uri.parse('$STORAGE_API$LOGIN_ENDPOINT'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'username':
              CredentialsFields.username.getValue(await getCredentials()),
          'password':
              CredentialsFields.password.getValue(await getCredentials()),
        },
      ),
    );

    late String token = getRawText(response);

    if (token.isEmpty) {
      throw Exception(ERROR_FILEBROWSER_LOGIN_FAILED);
    }

    return token;
  } catch (e) {
    throw Exception(ERROR_FILEBROWSER_LOGIN_FAILED);
  }
}

Future<File> getResourceFromFB(String shared_id) async {
  try {
    final response = await http.get(
      Uri.parse('$STORAGE_API$RECURSO_PUBLICO_ENDPOINT$shared_id'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    late dynamic body = getBody(response);
    late File file = File.fromJson(body);

    String mime_type = await getMymeTypeFromFB(shared_id);
    file.mime_type = mime_type;

    file.uri = buildStorageSharedFilePublicUrl(shared_id);

    return file;
  } catch (e) {
    throw Exception(ERROR_FILEBROWSER_GET_SHARED_FILE);
  }
}

Future<String> getMymeTypeFromFB(String shared_id) async {
  try {
    final response = await http.get(
      Uri.parse("${buildStorageSharedFilePublicUrl(shared_id)}true"),
    );

    if (response.statusCode != 200) {
      throw Exception();
    }

    return response.headers['content-type'] ?? '';
  } catch (e) {
    throw Exception(ERROR_FILEBROWSER_GET_SHARED_FILE);
  }
}

Future<List<String>> getPathsFromFB(String token) async {
  try {
    final response = await http.get(
      Uri.parse('$STORAGE_API$BUSQUEDA_ENDPOINT'),
      headers: {
        'X-Auth': token,
      },
    );

    List<dynamic> body = getBody(response);
    final List<String> paths = [];

    for (var item in body) {
      paths.add(item['path'] as String);
    }

    return paths;
  } catch (e) {
    throw Exception(ERROR_FILEBROWSER_GET_RESOURCE_LIST);
  }
}

Future<void> createFolderIfNotExists(String path, String? token) async {
  try {
    if (path.isEmpty) {
      return;
    }

    if (token == null || token.isEmpty) {
      token = await getFBAToken();
    }

    List<String> paths = await getPathsFromFB(token);

    List<String> sub_paths = path.split('/');
    for (int i = 0; i < sub_paths.length; i++) {
      String sub_path = sub_paths.sublist(0, i + 1).join('/');
      if (!paths.contains(sub_path)) {
        await createPath('$sub_path/', token).then((created_path) {
          paths.add(created_path);
        });
      }
    }
  } catch (e) {
    throw Exception(ERROR_FILEBROWSER_GET_RESOURCE_LIST);
  }
}

Future<String> createPath(String path, String? token) async {
  try {
    if (path.isEmpty) {
      return '';
    }

    if (token == null || token.isEmpty) {
      token = await getFBAToken();
    }

    await http.post(
      Uri.parse('$STORAGE_API$ARCHIVO_NUEVO_ENDPOINT$path')
          .replace(queryParameters: UPLOAD_QUERY_PARAMS),
      headers: {
        'X-Auth': token,
      },
    );

    return path;
  } catch (e) {
    throw Exception(ERROR_FILEBROWSER_GET_RESOURCE_LIST);
  }
}
