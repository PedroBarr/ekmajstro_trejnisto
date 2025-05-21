import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:ekmajstro_trejnisto/config/config.dart';
import 'package:ekmajstro_trejnisto/models/models.dart';

import 'router.dart';

dynamic getBody(http.Response response) {
  try {
    if (response.statusCode == 200 || response.statusCode == 201) {
      dynamic body = jsonDecode(response.body);
      return body;
    }

    throw Exception(ERROR_BODY);
  } catch (e) {
    throw Exception(ERROR_BODY);
  }
}

String buildIdRoute(String routeBase, ModelItem item) {
  return routeBase.replaceAll(ROUTE_ID_WILDCARD, item.id!.toString());
}

String buildIdRouteById(String routeBase, int id) {
  return routeBase.replaceAll(ROUTE_ID_WILDCARD, id.toString());
}

String buildSubRoute(List<String> subRoutes) {
  return subRoutes.join('');
}

bool isNumeric(String str) {
  return int.tryParse(str) != null;
}

void showMessage(String message, BuildContext context) {
  if (message.isNotEmpty) {
    final snack = SnackBar(
      content: Text(message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snack);
  }
}
