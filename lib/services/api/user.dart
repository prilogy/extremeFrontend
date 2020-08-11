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
      // var user = Models.User.fromJson(response.data);
      print('confirm Email request: \n \n ' + response.data.toString());
      return response;
    } on DioError catch (e) {
      print(e);
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
      print(e);
      return null;
    }
  }

  static Future<Models.User> edit(String name, String email) async {
    var form;
    if (name != null && email != null) {
      form = FormData.fromMap({'name': name, 'email': email});
    } else if (name != null && email == null) {
      form = FormData.fromMap({'name': name});
    } else if (name == null && email != null) {
      form = FormData.fromMap({'email': email});
    }

    var params = {
      'token': true,
    };
    try {
      var response =
          await dio.patch('/user/edit', data: form, queryParameters: params);
      print('It is okay: ' + response.statusCode.toString());
      print(response.data);
      return Models.User.fromJson(response.data);
    } on DioError catch (e) {
      //обработка ошибочных кодов
      print('Error: ' + e.response.statusCode.toString());
      return null;
    }
  }
}
