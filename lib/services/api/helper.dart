part of api;

class Helper {
  static Future<List<Models.Banner>> getBanner() async {
    try {
      var response = await dio.get('/helper/banner');
      //var entity = response.data[0]['entity'];
print('response: ' + response.data.toString());
List<Models.Banner> banners;
      List<Models.Content> entities;
      response.data.forEach((v) {
        entities.add(Models.Content.fromJson(v['entity']['content']));

      });
      return banners;
    } on DioError catch (e) {
      return null;
    }
  }
}
