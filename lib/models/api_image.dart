import 'package:extreme/config/env.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class ApiImage {
  String path;

  ApiImage(String path) {
    this.path = Config.API_BASE_URL + path;
  }
}
