part of api;

class Entities {
  static Future<List<T>> getAll<T>(
      [int page, int pageSize, String sortByDate = 'desc']) async {
    var entityName = _entityNameFromType(T);
    if (entityName == null) return null;

    try {
      var params = _generateParams(page, pageSize, sortByDate);
      var response = await dio.get('/$entityName', queryParameters: params);
      var entities = List<T>();
      response.data.forEach((v) {
        entities.add(_entityFromJson<T>(v));
      });

      return entities;
    } on DioError catch (e) {
      print(e);
      return null;
    }
  }

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
      var result = List<Models.Video>();
      response.data.forEach((v) {
        result.add(Models.Video.fromJson(v));
      });
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

  static String _entityNameFromType(Type t) {
    switch (t) {
      case Models.Video:
        return 'video';
      case Models.Playlist:
        return 'playlist';
      case Models.Movie:
        return 'movie';
      case Models.Sport:
        return 'sport';
      default:
        return null;
    }
  }

  static Map<String, dynamic> _generateParams(
      int page, int pageSize, String sortByDate) {
    var map = Map<String, dynamic>();
    if (page != null) map.addAll({'page': page});
    if (pageSize != null) map.addAll({'pageSize': pageSize});
    if (sortByDate != null && sortByDate == 'desc' || sortByDate == 'asc')
      map.addAll({'sortByDate': sortByDate});
    return map;
  }

  static T _entityFromJson<T>(dynamic v) {
    switch (T) {
      case Models.Video:
        return Models.Video.fromJson(v) as T;
      case Models.Movie:
        return Models.Movie.fromJson(v) as T;
      case Models.Sport:
        return Models.Sport.fromJson(v) as T;
      case Models.Playlist:
        return Models.Playlist.fromJson(v) as T;
      default:
        return null;
    }
  }
}
