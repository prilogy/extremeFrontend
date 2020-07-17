import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  String API_BASE_URL;

  EnvConfig({this.API_BASE_URL});

  static Future<EnvConfig> get(String path) async {
    String getKey(String key) => DotEnv().env[key] ?? null;

    await DotEnv().load(path);
    var env = EnvConfig();
    env.API_BASE_URL = getKey("API_BASE_URL");
    return env;
  }
}

EnvConfig Config;


