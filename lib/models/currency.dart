part of models;

class Currency {
  String key;

  CurrencyTypes get value {
    CurrencyTypes type;
    CurrencyTypes.values.forEach((currency) {
      if(currency.toString().split('.').last == key)
        type = currency;
    });

    return type;
  }

  Currency({this.key});

  Currency.fromJson(Map<String, dynamic> json) {
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    return data;
  }
}

enum CurrencyTypes {
  RUB,
  EUR,
  USD
}