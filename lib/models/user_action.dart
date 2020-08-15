part of models;

class UserAction {
  int id;
  bool status;
  String entityType;

  UserAction({this.id, this.status, this.entityType});

  UserAction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    entityType = json['entityType'].toString().toLowerCase();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['entityType'] = this.entityType;
    return data;
  }

  static const String video = "video";
  static const String movie = "movie";
  static const String playlist = "playlist";
  static const String sport = "sport";
}