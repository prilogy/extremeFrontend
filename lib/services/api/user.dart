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

  static Future<Models.User> edit(String name, String email) async {
    var form;
    if (name != null && email != null) {
      form = FormData.fromMap({'name': name, 'email': email});
    } else if (name != null && email == null)
    {
      form = FormData.fromMap({'name': name});
    } else if (name == null && email != null)
    {
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
