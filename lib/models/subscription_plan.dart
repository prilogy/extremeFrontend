part of models;

class SubscriptionPlan {
  int id;
  int duration;
  Content content;
  Price price;
  String color;

  SubscriptionPlan.fromJson(Map<String, dynamic> json) {
    price = json['price'] != null ? new Price.fromJson(json['price']) : null;
    content =
        json['content'] != null ? new Content.fromJson(json['content']) : null;
    color = json['color'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.content != null) {
      data['content'] = this.content.toJson();
    }
    data['id'] = this.id;
    data['price'] = this.price.toString();
    data['color'] = this.color;
    return data;
  }
}
