part of models;

class Currency {
  String key;
  String name;
  String symbol;

  Currency({this.key, this.name, this.symbol});

  Currency.fromJson(Map<String, dynamic> json) {
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    return data;
  }

  bool operator ==(dynamic other) =>
      other != null && other is Currency && this.key == other.key;

  @override
  int get hashCode => super.hashCode;

  static Currency RUB = Currency(key: 'RUB', name: "Рубль", symbol: '₽');
  static Currency USD = Currency(key: 'USD', name: "Dollar", symbol: '\$');
  static Currency EUR = Currency(key: 'EUR', name: "Euro", symbol: '€');

  static List<Currency> all = [RUB, USD, EUR];
}