part of api;

class Entities {
  /// Возвращает все доступные объекты выбранной модели
  static Future<List<T>> getAll<T>(
      [int? page, int? pageSize, String? sortByDate]) async {
    var entityName = _entityNameFromType(T);
    if (entityName == null) return [];

    try {
      var params = _generateParams(page, pageSize, sortByDate);
      var response = await dio.get('/$entityName', queryParameters: params);
      print(T.toString() + ": " + pageSize.toString() + "->" + (response.data as List<dynamic>).length.toString());
      List<T> entities = [];
      response.data.forEach((v) {
        var toAdd = _entityFromJson<T>(v);
        if(toAdd != null) entities.add(toAdd);
      });


      return entities;
    } on DioError catch (e) {
      print(e);
      return [];
    }
  }

  /// Возвращает объект выбранной модели с указанным id
  static Future<T?> getById<T>([int? id]) async {
    var entityName = _entityNameFromType(T);
    if (entityName == null) return null;

    try {
      var url = '/$entityName/$id';
      var response = await dio.get(url);
      var entity = _entityFromJson<T>(response.data);
      return entity;
    } on DioError catch (e) {
      return null;
    }
  }

  static Future<List<T>?> getByIds<T>(List<int> ids,
      [int? page, int? pageSize, String? sortByDate]) async {
    var entityName = _entityNameFromType(T);
    if (entityName == null) return null;

    try {
      var body = json.encode(ids);
      print(body);
      var params = _generateParams(page, pageSize, sortByDate);
      var response =
          await dio.post('/$entityName', queryParameters: params, data: body);
      List<T> entities = [];
      print(T.toString() + ": " + pageSize.toString() + "->" + (response.data as List<dynamic>).length.toString());
      response.data.forEach((v) {
        var toAdd = _entityFromJson<T>(v);
        if(toAdd != null) entities.add(toAdd);
      });
      return entities;
    } on DioError catch (e) {
      print(e);
      return null;
    }
  }

  /// Возвращает рекомендованный контент
  static Future<List<T>?> recommended<T>([int? page, int? pageSize]) async {
    var entityName = _entityNameFromType(T);
    if (entityName == null) return null;

    try {
      var params = _generateParams(page, pageSize, null);
      var response =
          await dio.get('/$entityName/recommended', queryParameters: params);
      List<T> entities = [];
      response.data.forEach((v) {
        var toAdd = _entityFromJson<T>(v);
        if(toAdd != null) entities.add(toAdd);
      });

      return entities;
    } on DioError catch (e) {
      return null;
    }
  }

  ///Список популярных(по лайкам)
  ///Только для playlist
  static Future<List<T>?> popular<T>([int? page, int? pageSize]) async {
    var entityName = _entityNameFromType(T);
    if (entityName == null) return null;

    try {
      var params = _generateParams(page, pageSize, null);
      var response =
      await dio.get('/$entityName/popular', queryParameters: params);
      List<T> entities = [];
      response.data.forEach((v) {
        var toAdd = _entityFromJson<T>(v);
        if(toAdd != null) entities.add(toAdd);
      });

      return entities;
    } on DioError catch (e) {
      return null;
    }
  }

  static String? _entityNameFromType(Type t) {
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
        throw Exception("No model Provided.");
    }
  }

  static Map<String, dynamic> _generateParams(
      int? page, int? pageSize, String? sortByDate) {
    var map = Map<String, dynamic>();
    if (page != null) map.addAll({'page': page});
    if (pageSize != null) map.addAll({'pageSize': pageSize});
    if (sortByDate != null && sortByDate == 'desc' || sortByDate == 'asc')
      map.addAll({'orderByDate': sortByDate});
    return map;
  }

  static T? _entityFromJson<T>(dynamic v) {
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
