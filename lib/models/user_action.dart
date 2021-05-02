part of models;

class UserAction {
  EntityIdItem? entityIdItem;
  bool? status;
  String? entityType;

  UserAction({this.entityIdItem, this.status, this.entityType});

  UserAction.fromJson(Map<String, dynamic> json) {
    entityIdItem = json['entityIdItem'] != null
        ? new EntityIdItem.fromJson(json['entityIdItem'])
        : null;
    status = json['status'];
    entityType = json['entityType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.entityIdItem != null) {
      data['entityIdItem'] = this.entityIdItem?.toJson();
    }
    data['status'] = this.status;
    data['entityType'] = this.entityType;
    return data;
  }
}


class EntityIdItem {
  int? id;
  int? entityId;

  EntityIdItem({this.id, this.entityId});

  EntityIdItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    entityId = json['entityId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['entityId'] = this.entityId;
    return data;
  }

  bool operator ==(dynamic other) =>
      other != null && other is EntityIdItem && this.id == other.id && this.entityId == other.entityId;

  @override
  int get hashCode => super.hashCode;
}