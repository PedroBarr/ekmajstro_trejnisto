import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'app.dart';
import 'misc.dart';

import 'package:ekmajstro_trejnisto/config/config.dart';

const String LOGIN_ENDPOINT = '/login';

Future<String> getFBAToken(String username, String password) async {
  try {
    final response = await http.post(
      Uri.parse('$STORAGE_API$LOGIN_ENDPOINT'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'username': username,
          'password': password,
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
