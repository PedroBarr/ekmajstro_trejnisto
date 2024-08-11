import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:ekmajstro_trejnisto/config/config.dart';
import 'package:ekmajstro_trejnisto/models/models.dart';

import 'router.dart';

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

String buildIdRoute(String route_base, ModelItem item) {
  return route_base.replaceAll(ROUTE_ID_WILDCARD, item.id!.toString());
}

bool isNumeric(String str) {
  return int.tryParse(str) != null;
}
