import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiImage {
  String path;

  ApiImage(String path) {
    this.path = DotEnv().env["API_BASE_URL"] + path;
  }
}
