part of api;

// Класс только для эндпоинтов User из постман
class User {
  // так же другие методы
  static Future<Models.User> info() async {
    try {
      var response = await dio.get('/auth/refresh', queryParameters: {
        'token': false,
      });
      return Models.User.fromJson(response.data);
    } on DioError catch (e) {
      //обработка ошибочных кодов
      print('Error: ' + e.response.statusCode.toString());
      return null;
    }
  }
}
