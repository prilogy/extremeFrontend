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
  static Future<List<Models.SubscriptionPlan>> getPlans() async {
    try {
      var response = await dio.get('/subscription');
      print(response.data.toString());
            var entities = List<Models.SubscriptionPlan>();
      response.data.forEach((v) {
        entities.add(Models.SubscriptionPlan.fromJson(v));
      });
      return entities;
    }on DioError catch (e) {
      print('Error: ' + e.response.statusCode.toString());
      return null;
    }
  }
}