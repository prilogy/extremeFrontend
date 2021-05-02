part of models;

class Culture {
  String? key;
  String? name;

  Culture({this.key, this.name});

  Culture.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['name'] = this.name;
    return data;
  }

  static List<Culture> all = [ru, en];

  static Culture ru = Culture(key: 'ru', name: 'Русский');
  static Culture en = Culture(key: 'en', name: 'English');

  bool operator ==(dynamic other) =>
      other != null && other is Culture && this.key == other.key;

  @override
  int get hashCode => super.hashCode;
}