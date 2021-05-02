part of api;

class Subscription {
  static Future<String?> getPaymentUrl(int id) async {
    try {
      var response = await dio.get('/subscription/$id');
      return response.data.toString();
    } on DioError catch (e) {
      return null;
    }
  }

  static Future<List<Models.SubscriptionPlan>?> getPlans() async {
    try {
      var response = await dio.get('/subscription');
      List<Models.SubscriptionPlan> entities = [];
      response.data.forEach((v) {
        entities.add(Models.SubscriptionPlan.fromJson(v));
      });
      return entities;
    } on DioError catch (e) {
      return null;
    }
  }
}
