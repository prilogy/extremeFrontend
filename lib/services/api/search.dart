part of api;

/// Класс поиска
class Search {
  /// Глобальный поиск
  static Future<Models.SearchResult> global({String query}) async {
    try {
      var response = await dio.post('/search', data: json.encode(query));
      print('Response data: \n ' + response.data.toString());
      var result = Models.SearchResult.fromJson(response.data);
      return result;
    } on DioError catch (e) {
      //обработка ошибочных кодов
      print('Error: ' + e.response.statusCode.toString());
      return null;
    }
  }
}
