part of models;

class PromoCode {
  SubscriptionPlan subscriptionPlan;
  Map<String, dynamic> entitySaleable;

  PromoCode({this.subscriptionPlan, this.entitySaleable});

  PromoCode.fromJson(Map<String, dynamic> json) {
    entitySaleable = json['entitySaleable'];
    subscriptionPlan = json['subscriptionPlan'] != null
        ? new SubscriptionPlan.fromJson(json['subscriptionPlan'])
        : null;
  }
}