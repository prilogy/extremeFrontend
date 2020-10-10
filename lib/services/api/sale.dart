part of api;

/// Класс покупок
class Sale {
  /// Глобальный поиск
  static Future<String> getPaymentUrl(int id) async {
    try {
      var response = await dio.get('/sale/$id');
      return response.data.toString();
    } on DioError catch (e) {
      return null;
    }
  }
}
