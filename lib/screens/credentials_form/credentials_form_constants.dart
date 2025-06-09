import 'package:ekmajstro_trejnisto/utils/utils.dart';

const String SAVE_CREDENTIALS = 'Confirmar credenciales';
const String SAVE_CREDENTIALS_SUCCESS_MESSAGE =
    'Credenciales guardadas correctamente';
const String SAVE_CREDENTIALS_ERROR_MESSAGE =
    'Error al guardar las credenciales: ';

CredentialsFields getCredentialField(String key) {
  return CredentialsFields.values.firstWhere((field) => field.getKey() == key);
}

String getCredentialLabel(String key) {
  return getCredentialField(key).getLabel();
}
