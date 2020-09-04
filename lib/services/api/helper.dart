part of api;

class Helper {
  static Future<List<Models.Banner>> getBanner() async {
    try {
      var response = await dio.get('/helper/banner');
      //var entity = response.data[0]['entity'];
      print('response: ' + response.data.toString());
      List<Models.Banner> banners = List<Models.Banner>();
      response.data.forEach((v) {
        banners.add(Models.Banner.fromJson(v));
      });
      print(banners);
      return banners;
    } on DioError catch (e) {
      return null;
    }
  }
}
