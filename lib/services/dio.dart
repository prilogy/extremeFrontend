import 'package:dio/dio.dart';
import 'package:extreme/config/env.dart' as Env;

Dio dio;

void init() {
  dio = new Dio();
  dio.options.baseUrl = Env.config.API_BASE_URL + '/api';
}
