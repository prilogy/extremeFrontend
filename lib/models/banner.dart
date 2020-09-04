part of models;

class Banner {
  int id;
  // Content content;
  int entityId;
  Content content;
  Content entityContent;

  Banner({this.id, this.content, this.entityId, this.entityContent});

  Banner.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? json['id'] : null;
    entityId = json['entityId'] != null ? json['entityId'] : null;
    content = Content.fromJson(json['content']) ?? Content();
    entityContent = Content.fromJson(json['entityContent']);
  }
}
