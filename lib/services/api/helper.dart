part of api;

class Helper {
  static Future<List<Models.Content>> getBanner() async {
    try {
      var response = await dio.get('/helper/banner');
      //var entity = response.data[0]['entity'];
      var entities = List<Models.Content>();
      response.data.forEach((v) {
        entities.add(Models.Content.fromJson(v['entity']['content']));
      });
      return entities;
    } on DioError catch (e) {
      return null;
    }
  }
}
