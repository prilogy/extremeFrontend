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

  static Future<dynamic> confirmEmailRequest() async {
    try {
      var response = await dio.get('/user/verifyEmail');
      return response;
    } on DioError catch (e) {
      return null;
    }
  }

  static Future<bool> confirmEmailAttempt(String code) async {
    try {
      var body = json.encode(code);
      var response = await dio.post('/user/verifyEmail', data: body);
      return true;
    } on DioError catch (e) {
      return false;
    }
  }

  static Future<Models.User> edit({String name, String email}) async {
    var map = Map<String, dynamic>();
    if (name != null) map.addAll({'name': name});
    if (email != null) map.addAll({'email': email});

    try {
      var response = await dio.patch('/user/edit', data: FormData.fromMap(map));
      return Models.User.fromJson(response.data);
    } on DioError catch (e) {

      return null;
    }
  }

  /// Переключатель favorite
  static Future<Models.UserAction> toggleFavorite(int id) async {
    try {
      var response = await dio.get('/user/favorite/$id');
      return Models.UserAction.fromJson(response.data);
    } on DioError catch (e) {
      return null;
    }
  }

  /// Переключатель like
  static Future<Models.UserAction> toggleLike(int id) async {
    try {
      var response = await dio.get('/user/like/$id');
      return Models.UserAction.fromJson(response.data);
    } on DioError catch (e) {
      return null;
    }
  }

  /// Запрос на смену пароля
  static Future<dynamic> resetPasswordRequest(String email) async {
    try {
      var data = json.encode(email);
      await dio.post('/user/resetPassword', data: data);

      return null;
    } on DioError catch (e) {
      return null;
    }
  }

  /// Верификация кода, полученного с email
  static Future<bool> verify(String code) async {
    try {
      var data = json.encode(code);
      await dio.post('/user/resetPassword/verify', data: data);
      return true;
    } on DioError catch (e) {
      return false;
    }
  }

  /// Попытка смены пароля, после верификации
  static Future<bool> resetPasswordAttempt(
      String code, String newPass) async {
    try {
      var data = {'code': code, 'password': newPass};
      var response = await dio.patch('/user/resetPassword', data: data);
      return true;
    } on DioError catch (e) {
      return false;
    }
  }

  static Future<bool> addSocialAccount(
      Models.SocialAccountProvider provider, String token) async {
    try {
      await dio
          .put('/user/socialAccount/${provider.name}', data: {'token': token});

      return true;
    } on DioError catch (e) {
      return null;
    }
  }

  static Future<bool> removeSocialAccount(
      Models.SocialAccountProvider provider) async {
    try {
      await dio.delete('/user/socialAccount/${provider.name}');

      return true;
    } on DioError catch (e) {
      return null;
    }
  }
}
