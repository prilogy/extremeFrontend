part of models;

class Currency {
  String key;
  String name;
  String symbol;
  String pattern;

  Currency({this.key, this.name, this.symbol, this.pattern});

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

  static Currency RUB = Currency(key: 'RUB', name: "Рубль", symbol: '₽', pattern: '{0}₽');
  static Currency USD = Currency(key: 'USD', name: "Dollar", symbol: '\$', pattern: '\${0}');
  static Currency EUR = Currency(key: 'EUR', name: "Euro", symbol: '€', pattern: '€{0}');

  static List<Currency> all = [RUB, USD, EUR];
}