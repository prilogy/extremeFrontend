part of models;

class Culture {
  String key;

  CultureTypes get value {
    CultureTypes type;
    CultureTypes.values.forEach((culture) {
      if(culture.toString().split('.').last == key)
        type = culture;
    });

    return type;
  }

  Culture({this.key});

  Culture.fromJson(Map<String, dynamic> json) {
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    return data;
  }
}

enum CultureTypes {
  en,
  ru
}