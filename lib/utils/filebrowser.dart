import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;

import 'package:http/http.dart' as http;

import 'app.dart';
import 'misc.dart';
import 'api.dart';
import 'auth.dart';

import 'package:ekmajstro_trejnisto/models/models.dart';
import 'package:ekmajstro_trejnisto/config/config.dart';

const String LOGIN_ENDPOINT = '/login';
const String RECURSO_PUBLICO_ENDPOINT = '/public/share/';
const String ARCHIVO_NUEVO_ENDPOINT = '/resources';
const String BUSQUEDA_ENDPOINT = '/search';
const String COMPARTIR_ENDPOINT = '/share/';

const String RUTA_ALMACENAMIENTO = '/Almacenamiento/Publicaciones/';

const Map<String, String> UPLOAD_QUERY_PARAMS = {
  'override': 'false',
};

const Map<String, dynamic> SHARE_FILE_SETTINGS = {};

String buildPath({String? post_folder = '', String? file_name = ''}) {
  String path = RUTA_ALMACENAMIENTO;

  if (post_folder != null && post_folder.isNotEmpty) {
    path += post_folder + '/';
  }

  if (file_name != null && file_name.isNotEmpty) {
    path += file_name;
  }

  return path;
}

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

Future<String> uploadFileToFB(io.File file, int? post_id) async {
  try {
    late String folder_name = '';

    if (post_id != null) {
      folder_name = await getPost(post_id.toString()).then((post) {
        return post.title;
      });
    } else {
      folder_name = '';
    }

    String token = await getFBAToken();

    String path = buildPath(post_folder: folder_name);

    await createFolderIfNotExists(path, token);

    String file_name = file.path.split('/').last;
    String full_path =
        buildPath(post_folder: folder_name, file_name: file_name);

    List<int> file_bytes = await file.readAsBytes();

    await http.post(
      Uri.parse('$STORAGE_API$ARCHIVO_NUEVO_ENDPOINT$full_path')
          .replace(queryParameters: UPLOAD_QUERY_PARAMS),
      headers: {
        'Content-Type': 'application/octet-stream',
        'X-Auth': token,
      },
      body: file_bytes,
    );

    return Future.value(full_path);
  } catch (e) {
    throw Exception(ERROR_FILEBROWSER_UPLOAD_FILE);
  }
}

Future<String> shareFBResource(String file_path) async {
  try {
    final token = await getFBAToken();

    final response = await http.post(
      Uri.parse('$STORAGE_API$COMPARTIR_ENDPOINT$file_path'),
      headers: {
        'X-Auth': token,
        'Content-Type': 'application/json',
      },
      body: jsonEncode(SHARE_FILE_SETTINGS),
    );

    late dynamic body = getBody(response);
    late String shared_id = body['hash'] as String;

    if (shared_id.isEmpty) {
      throw Exception(ERROR_FILEBROWSER_GET_SHARED_FILE);
    }

    return shared_id;
  } catch (e) {
    throw Exception(ERROR_FILEBROWSER_GET_SHARED_FILE);
  }
}
