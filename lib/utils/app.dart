const String BACKEND_APP = 'https://ekcion-api.up.railway.app';

const String BACKEND_API = '$BACKEND_APP/api';
const String BACKEND_ASSETS = '$BACKEND_APP/assets';

const String FRONTEND_APP =
    'https://pedrobarr.github.io/ekmajstro_pre_cion_frontend';

const String STORAGE_APP = 'https://filebrowser-production-26bd.up.railway.app';
const String STORAGE_API = '$STORAGE_APP/api';

String buildStorageSharedFilePublicUrl(String shared_id) {
  return '$STORAGE_API/public/dl/$shared_id?inline=';
}
