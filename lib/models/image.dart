part of models;

class Image {
  String? _path;

  String get path => Env.config!.API_BASE_URL + (_path ?? '');

  Image({String? path}): _path = path;

  Image.fromJson(Map<String, dynamic> json) {
    _path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['path'] = this.path;
    return data;
  }
}