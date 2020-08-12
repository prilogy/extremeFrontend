part of api;

// Класс только для эндпоинтов User из постман
class User {
  // так же другие методы
  static Future<Models.User> refresh(
      [bool token = false, bool updateStore = false]) async {
    try {
      var headers = {
        'Culture': store.state.settings?.culture?.key,
        'Currency': store.state.settings?.currency?.key
      };

      var response = await dio.get('/auth/refresh',
          queryParameters: {
            'token': token,
          },
          options: Options(headers: headers));

      var user = Models.User.fromJson(response.data);
      if (updateStore) store.dispatch(SetUser(user));
      return user;
    } on DioError catch (e) {
      return null;
    }
  }

  static Future<dynamic> confirmEmailRequset() async {
    try {
      var response = await dio.get('/user/verifyEmail');
      return response;
    } on DioError catch (e) {
      return null;
    }
  }

  static Future confirmEmailAttempt(int code) async {
    try {
      var body = json.encode(code);
      var response = await dio.post('/user/verifyEmail', data: body);
      if (response.statusCode == 200) {
        
      }
      return response;
    } on DioError catch (e) {
      return null;
    }
  }

  static Future<Models.User> edit({String name, String email}) async {
    var map = Map<String, dynamic>();
    if(name != null) map.addAll({'name': name});
    if(email != null) map.addAll({'email': name});

    try {
      var response =
          await dio.patch('/user/edit', data: FormData.fromMap(map));
      print(response.data);
      return Models.User.fromJson(response.data);
    } on DioError catch (e) {
      return null;
    }
  }
}
