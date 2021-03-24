import 'package:flutter_dotenv/flutter_dotenv.dart';

EnvConfig config;

Future<void> init(String path) async {
  String getKey(String key) => DotEnv().env[key] ?? null;

  await DotEnv().load(path);
  config = EnvConfig(
      API_BASE_URL: DotEnv().env['API_BASE_URL'] ?? null,
      VK_APP_ID: DotEnv().env['VK_APP_ID'] ?? null
  );
}

class EnvConfig {
  String API_BASE_URL;
  String VK_APP_ID;

  EnvConfig({this.API_BASE_URL, this.VK_APP_ID});
}
