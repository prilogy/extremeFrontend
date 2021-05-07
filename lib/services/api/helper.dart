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

  static Future<PaymentStatus> paymentCheckStatus(String url) async {
    try {
      await dio.post('/helper/CheckStatus',
          data: jsonEncode(url), options: Options(validateStatus: (s) => s == 200));
      return PaymentStatus.Success;
    } on DioError catch (e) {
      print("statusc ode " + (e.response?.statusCode.toString() ?? ""));
      var statusCode = e.response?.statusCode;
      if (statusCode == 426)
        return PaymentStatus.UpdateRequired;
      else
        return PaymentStatus.Failed;
    }
  }
}

