part of models;

class Price {
  Currency currency;
  int value;

  Price({this.currency, this.value});

  Price.fromJson(Map<String, dynamic> json) {
    currency = json['currency'] != null
        ? new Currency.fromJson(json['currency'])
        : null;
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.currency != null) {
      data['currency'] = this.currency.toJson();
    }
    data['value'] = this.value;
    return data;
  }
}