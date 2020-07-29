import 'package:dio/dio.dart';
import 'package:extreme/config/env.dart' as Env;
import 'package:extreme/store/main.dart';

final Dio dio = new Dio();

void init() {
  dio.options.baseUrl = Env.config.API_BASE_URL + '/api';
  dio.interceptors
      .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
    var customHeaders = {"Authorization": store.state.user?.token == null ? null : 'Bearer ${store.state.user.token}'};
    options.headers.addAll(customHeaders);
    return options;
  }));
}
