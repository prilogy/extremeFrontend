part of api;

class Entities {
  /// Возвращает список всех видов спорта и информацию о каждом
  static Future<List<Models.Sport>> sports() async {
    try {
      var response = await dio.get('/sport');
      var sports = List<Models.Sport>();
      response.data.forEach((v) {
        sports.add(Models.Sport.fromJson(v));
      });
      return sports;
    } on DioError catch (e) {
      //обработка ошибочных кодов
      print('Error: ' + e.response.statusCode.toString());
      return null;
    }
  }

  /// Возвращает список всех плейлистов и информацию о каждом
  static Future<List<Models.Playlist>> playlists(int page, int pageSize) async {
    var params = {
      'page': page.toString(),
      'pageSize': pageSize.toString(),
      'sortByDate': 'desc',
    };
    try {
      var response = await dio.get('/playlist', queryParameters: params);
      var result = List<Models.Playlist>();
      response.data.forEach((v) {
        result.add(Models.Playlist.fromJson(v));
      });
      return result;
    } on DioError catch (e) {
      //обработка ошибочных кодов
      print('Error: ' + e.response.statusCode.toString());
      return null;
    }
  }

  /// Возвращает список видео в плейлисте
  static Future<List<Models.Video>> playlistVideos(int playlistID) async {
    try {
      var response = await dio.get('/playlist/$playlistID');
      var videosIds = response.data['videosIds'];
      var result = List<Models.Video>();
      var secondResponse = await dio.post('/video/');

        result.add(Models.Video.fromJson(secondResponse.data));

      return result;
    } on DioError catch (e) {
      //обработка ошибочных кодов
      print('Error: ' + e.response.statusCode.toString());
      return null;
    }
  }

  /// Возвращает список всех фильмов и информацию о каждом
  static Future<List<Models.Movie>> movies(int page, int pageSize) async {
    var params = {
      'page': page.toString(),
      'pageSize': pageSize.toString(),
      'sortByDate': 'desc',
    };
    try {
      var response = await dio.get('/movie', queryParameters: params);
      var result = List<Models.Movie>();
      response.data.forEach((v) {
        result.add(Models.Movie.fromJson(v));
      });
      return result;
    } on DioError catch (e) {
      //обработка ошибочных кодов
      print('Error: ' + e.response.statusCode.toString());
      return null;
    }
  }
}
