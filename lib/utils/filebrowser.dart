import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'app.dart';
import 'misc.dart';

Future<String> getFBAToken(String username, String password) async {
  try {
    final response = await http.post(
      Uri.parse('$STORAGE_API/login'),
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
      throw Exception('Invalid username or password');
    }

    return token;
  } catch (e) {
    throw Exception('Error connecting to File Browser API: $e');
  }
}
