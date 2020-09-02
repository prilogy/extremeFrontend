part of models;

class Playlist {
  int sportId;
  List<int> videosIds;
  Content content;
  Price price;
  bool isPaid;
  int salesAmount;
  int id;
  int likesAmount;
  String entityType;
  DateTime dateCreated;

  bool get isFavorite {
    return store.state.user?.favoriteIds?.playlists?.any((x) => x.entityId == id) ?? false;
  }

  bool get isInPreferredLanguage {
    return store.state?.settings?.culture == content?.culture ?? false;
  }

  Playlist(
      {this.sportId,
      this.videosIds,
      this.content,
      this.price,
      this.isPaid,
      this.salesAmount,
      this.id,
      this.dateCreated,
      this.likesAmount,
      this.entityType});

  Playlist.fromJson(Map<String, dynamic> json) {
    sportId = json['sportId'] ?? [];
    videosIds = json['videosIds']?.cast<int>() ?? [];
    content =
        json['content'] != null ? new Content.fromJson(json['content']) : null;
    price = json['price'] != null ? new Price.fromJson(json['price']) : null;
    isPaid = json['isPaid'];
    salesAmount = json['salesAmount'];
    id = json['id'];
    dateCreated = DateTime.parse(json['dateCreated']).toLocal();
    likesAmount = json['likesAmount'] ?? 0;
    entityType = json['entityType']?.toString()?.toLowerCase() ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sportId'] = this.sportId;
    data['videosIds'] = this.videosIds;
    if (this.content != null) {
      data['content'] = this.content.toJson();
    }
    if (this.price != null) {
      data['price'] = this.price.toJson();
    }
    data['isPaid'] = this.isPaid;
    data['salesAmount'] = this.salesAmount;
    data['id'] = this.id;
    data['dateCreated'] = this.dateCreated.toString();
    data['likesAmount'] = this.likesAmount.toString();
    data['entityType'] = this.entityType.toString();
    return data;
  }
}
