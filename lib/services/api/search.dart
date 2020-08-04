part of api;

/// Класс поиска
class Search {
  /// Глобальный поиск
  static Future<Models.SearchResult> global({String query}) async {
    try {
      var response = await dio.post('/search', data: json.encode(query));
      print('Response data for query($query): \n ' + response.data.toString());
      var result = Models.SearchResult.fromJson(response.data);
      return result;
    } on DioError catch (e) {
      //обработка ошибочных кодов
      print('Error: ' + e.response.statusCode.toString());
      return null;
    }
  }

  static Future<List<Models.Sport>> sports() async {
    try {
      var response = await dio.get('/sport');
      print('Response data for sports: \n ' + response.data.toString());
      var result = response.data.map<Models.Sport>((e) => Models.Sport.fromJson(response.data)).toList();
      return result;
    } on DioError catch (e) {
      //обработка ошибочных кодов
      print('Error: ' + e.response.statusCode.toString());
      return null;
    }
  }
}
