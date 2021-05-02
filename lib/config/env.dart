import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

EnvConfig? config;

Future<void> init(String path) async {
  await DotEnv.load(fileName: path);
  config = EnvConfig(
      API_BASE_URL: DotEnv.env['API_BASE_URL'] ?? '',
      VK_APP_ID: DotEnv.env['VK_APP_ID'] ?? ''
  );
}

class EnvConfig {
  String API_BASE_URL;
  String VK_APP_ID;

  EnvConfig({this.API_BASE_URL = '', this.VK_APP_ID = ''});
}
