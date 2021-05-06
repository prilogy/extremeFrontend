part of api;

class AppleNotification {
  static Future<bool> payment(ApplePayment m) async {
    try {
      await dio.post('appleNotification/payment', data: m);
      return true;
    } on DioError catch (e) {
      return false;
    }
  }
}
