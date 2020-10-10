part of models;

class Price {
  Currency currency;
  double value;
  double discountValue;

  Price({this.currency, this.value});

  Price.fromJson(Map<String, dynamic> json) {
    currency = json['currency'] != null
        ? new Currency.fromJson(json['currency'])
        : null;
    value = json['value'];
    discountValue = json['discountValue'];
  }

  @override
  String toString() {
    var cur = Currency.all.firstWhere((x) => x == currency, orElse: () => null);
    var val =  value.toStringAsFixed(value / value == 1.0 ? 0 : 2);
    return cur?.pattern != null ? cur.pattern.replaceFirst('{0}', val) : 'Error';
  }

  String discountToString() {
    var cur = Currency.all.firstWhere((x) => x == currency, orElse: () => null);
    var val =  discountValue.toStringAsFixed(discountValue / discountValue == 1.0 ? 0 : 2);
    return cur?.pattern != null ? cur.pattern.replaceFirst('{0}', val) : 'Error';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.currency != null) {
      data['currency'] = this.currency.toJson();
    }
    data['value'] = this.value;
    data['discountValue'] = this.discountValue;
    return data;
  }
}