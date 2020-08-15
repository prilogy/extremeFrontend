part of api;

/// Класс поиска
class Search {
  /// Глобальный поиск
  static Future<Models.SearchResult> global({String query}) async {
    try {
      var response = await dio.post('/search', data: json.encode(query));
      var result = Models.SearchResult.fromJson(response.data);
      return result;
    } on DioError catch (e) {
      return null;
    }
  }
  
}
