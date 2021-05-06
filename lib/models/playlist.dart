part of models;

class Playlist extends IsWithInAppPurchaseKeys {
  int? sportId;
  List<int>? videosIds;
  Content? content;
  Price? price;
  bool? isPaid;
  int? salesAmount;
  int? id;
  int? likesAmount;
  String? entityType;
  DateTime? dateCreated;
  int? bestVideoId;

  bool get isBought {
    return isPaid == true &&
        (store.state.user!.saleIds?.playlists?.any((x) => x.entityId == id) ??
            false);
  }

  bool get isFavorite {
    return store.state.user!.favoriteIds?.playlists
            ?.any((x) => x.entityId == id) ??
        false;
  }

  bool get isInPreferredLanguage {
    return store.state.settings!.culture == content?.culture;
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
    entityType = json['entityType']?.toString().toLowerCase() ?? '';
    bestVideoId = json['bestVideoId'];
    appleInAppPurchaseKey = json['appleInAppPurchaseKey'];
    googleInAppPurchaseKey = json['googleInAppPurchaseKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sportId'] = this.sportId;
    data['videosIds'] = this.videosIds;
    if (this.content != null) {
      data['content'] = this.content?.toJson();
    }
    if (this.price != null) {
      data['price'] = this.price?.toJson();
    }
    data['isPaid'] = this.isPaid;
    data['salesAmount'] = this.salesAmount;
    data['id'] = this.id;
    data['dateCreated'] = this.dateCreated.toString();
    data['likesAmount'] = this.likesAmount.toString();
    data['entityType'] = this.entityType.toString();
    data['bestVideoId'] = this.bestVideoId;
    data['appleInAppPurchaseKey'] = appleInAppPurchaseKey;
    data['googleInAppPurchaseKey'] = googleInAppPurchaseKey;
    return data;
  }
}
