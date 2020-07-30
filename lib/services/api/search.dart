part of api;

/// Класс поиска
class Search {
  /// Глобальный поиск
  static Future<Models.Video> global({String query}) async {
    try {
      var response = await dio.post('/search', data: json.encode(query));
      print('Response data: \n ' + response.data['videos'][0].toString());
      var result = Models.Video.fromJson(response.data['videos'][0]);
      //var result = Models.Video(id: 1,isInPaidPlayList: false, content: Models.Content(name: 'ni',description: 'hi',url: 'fff'));
      return result;
    } on DioError catch (e) {
      //обработка ошибочных кодов
      print('Error: ' + e.response.statusCode.toString());
      return null;
    }
  }
}
