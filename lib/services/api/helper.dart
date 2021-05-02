part of api;

class Helper {
  static Future<List<Models.Banner>?> getBanner() async {
    try {
      var response = await dio.get('/helper/banner');
      List<Models.Banner> banners = [];
      response.data.forEach((v) {
        banners.add(Models.Banner.fromJson(v));
      });
      return banners;
    } on DioError catch (e) {
      return null;
    }
  }
}
