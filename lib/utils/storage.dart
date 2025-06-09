import 'dart:io' as io;

import 'package:path_provider/path_provider.dart';

const String STORAGE_LOCAL_CREDENTIALS_FILE = 'credentials.json';

Future<String> getStorageLocalPath() async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<io.File> getCredentialsFile() async {
  final path = await getStorageLocalPath();
  return io.File('$path/$STORAGE_LOCAL_CREDENTIALS_FILE');
}
