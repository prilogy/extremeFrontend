part of models;

class Banner {
  int id;
  // Content content;
  int entityId;
  Content content;
  Content entityContent;

  Banner({this.id, this.content, this.entityId, this.entityContent});

  Banner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    entityId = json['entityId'];
    content = json['content'] != null ? Content.fromJson(json['content']) : Content();
    entityContent = json['entity'] != null && json['entity']['content'] != null ? Content.fromJson(json['entity']['content']) : null;
  }
}
