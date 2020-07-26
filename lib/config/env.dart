import 'package:flutter_dotenv/flutter_dotenv.dart';

EnvConfig config;

Future<void> init(String path) async {
  String getKey(String key) => DotEnv().env[key] ?? null;

  await DotEnv().load(path);
  config = EnvConfig();
  config.API_BASE_URL = DotEnv().env['API_BASE_URL'] ?? null;
}

class EnvConfig {
  String API_BASE_URL;

  EnvConfig({this.API_BASE_URL});
}
