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

  /// Подсказка к поиску
  static Future<List<dynamic>> predict({String query}) async {
    try {
      var response =
          await dio.post('/search/predict', data: json.encode(query));
      List<dynamic> result = response?.data ?? [''];
      return result;
    } on DioError catch (e) {
      return null;
    }
  }

  static Future<Models.SearchResult> inPlaylist(int id, {String query}) async {
    try {
      var response =
          await dio.post('/playlist/$id/search', data: json.encode(query));
      var result = Models.SearchResult.fromJson(response.data);
      return result;
    } on DioError catch (e) {
      return null;
    }
  }

  static Future<Models.SearchResult> inSport(int id, {String query}) async {
    try {
      var response =
          await dio.post('/sport/$id/search', data: json.encode(query));
      var result = Models.SearchResult.fromJson(response.data);
      return result;
    } on DioError catch (e) {
      return null;
    }
  }
}
