import 'storage.dart';
import 'dart:convert';

const String AUTH_USERNAME_FILEBROWSER_KEY = 'username_filebrowser';
const String AUTH_PASSWORD_FILEBROWSER_KEY = 'password_filebrowser';

const String AUTH_USERNAME_FILEBROWSER_LABEL = 'Usuario de Filebrowser';
const String AUTH_PASSWORD_FILEBROWSER_LABEL = 'Contraseña de Filebrowser';

enum CredentialsFields {
  username(AUTH_USERNAME_FILEBROWSER_KEY, AUTH_USERNAME_FILEBROWSER_LABEL),
  password(AUTH_PASSWORD_FILEBROWSER_KEY, AUTH_PASSWORD_FILEBROWSER_LABEL);

  final String key;
  final String label;
  const CredentialsFields(this.key, this.label);

  String getKey() => key;
  String getLabel() => label;

  String getValue(Map<String, dynamic> credentials) {
    return credentials[key] ?? '';
  }

  void setValue(Map<String, dynamic> credentials, String value) {
    credentials[key] = value;
  }
}

Map<String, String> createDefaultCredentials(
  Map<String, dynamic> credentiales_actuales,
) {
  final Map<String, String> defaultCredentials = {};
  for (var field in CredentialsFields.values) {
    if (field.getValue(credentiales_actuales).isEmpty) {
      defaultCredentials[field.getKey()] = '';
    } else {
      defaultCredentials[field.getKey()] =
          field.getValue(credentiales_actuales);
    }
  }
  return defaultCredentials;
}

Future<Map<String, String>> getCredentials() async {
  final file = await getCredentialsFile();
  if (await file.exists()) {
    final content = await file.readAsString();
    if (content.isNotEmpty) {
      return Map<String, String>.from(jsonDecode(content));
    }
  } else {
    await file.create(recursive: true);

    await file.writeAsString(jsonEncode(createDefaultCredentials({})));
  }

  return createDefaultCredentials({});
}

Future<void> saveCredentials(Map<String, dynamic> credentials) async {
  final file = await getCredentialsFile();
  await file.writeAsString(jsonEncode(credentials));
}
