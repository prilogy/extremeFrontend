import 'package:dio/dio.dart';
import 'package:extreme/config/env.dart' as Env;

Dio dio;

void init() {
  dio = new Dio();
  dio.options.baseUrl = Env.config.API_BASE_URL + '/api';
  dio.interceptors
      .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
    var customHeaders = {"Authorization": "Bearer token"};
    options.headers.addAll(customHeaders);
    return options;
  }));
}
