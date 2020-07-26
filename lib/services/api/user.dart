part of api;

// Класс только для эндпоинтов User из постман
class User {
  static Future<Models.User> login(String email, String password) async {
    try {
      var response = await dio
          .post('/auth/login', data: {"email": email, "password": password});

      /* для дебага */
      var user = Models.User.fromJson(response.data);
      return user;
      /* --------- */
      // return Models.User.fromJson(response.data);
    } on DioError catch(e) {
      //обработка ошибочных кодов
      print(e.response.statusCode);
      return null;
    }
  }

  // так же другие методы
}
