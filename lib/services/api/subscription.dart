part of api;

class Subscription {
  static Future<String> getPaymentUrl(int id) async {
    try {
      var response = await dio.get('/subscription/$id');
      print(response.data.toString());
      return response.data.toString();
    } on DioError catch (e) {
      print('Error: ' + e.response.statusCode.toString());
      return null;
    }
  }
}