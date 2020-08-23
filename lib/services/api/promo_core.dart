part of api;

class PromoCode {
  static Future<Models.PromoCode> info(String code) async {
    try {
      var response = await dio.post('/promoCode', data: json.encode(code));
      var result = Models.PromoCode.fromJson(response.data);
      return result;
    } on DioError catch (e) {
      return null;
    }
  }

  static Future<bool> confirm(String code) async {
    try {
      var response = await dio.put('/promoCode', data: json.encode(code));
      return true;
    } on DioError catch (e) {
      return false;
    }
  }
}