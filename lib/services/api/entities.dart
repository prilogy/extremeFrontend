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
      return null;
    }
  }

  static Future<T> getById<T>([int id]) async {
    var entityName = _entityNameFromType(T);
    if (entityName == null) return null;

    try {
      var response = await dio.get('/$entityName/$id');
      var entity = _entityFromJson<T>(response.data);
      return entity;
    } on DioError catch (e) {
      return null;
    }
  }

  static Future<List<T>> getByIds<T>(
      [List<int> ids, String sortByDate = 'desc']) async {
    var entityName = _entityNameFromType(T);
    if (entityName == null) return null;

    try {
      var body = json.encode(ids);
      var params = {"sortByDate": sortByDate};
      var response = await dio.post('/$entityName', queryParameters: params, data: body);
      var entities = List<T>();
      response.data.forEach((v) {
        entities.add(_entityFromJson<T>(v));
      });
      return entities;
    } on DioError catch (e) {
      return null;
    }
  }
  /// Возвращает рекомендованный контент
static Future<List<T>> recommended<T>(
      [int page, int pageSize]) async {
    var entityName = _entityNameFromType(T);
    if (entityName == null) return null;

    try {
      var params = _generateParams(page, pageSize, null);
      var response = await dio.get('/$entityName/recommended', queryParameters: params);
      var entities = List<T>();
      response.data.forEach((v) {
        entities.add(_entityFromJson<T>(v));
      });

      return entities;
    } on DioError catch (e) {
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
