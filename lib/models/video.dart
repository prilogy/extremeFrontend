part of models;

class Video {
  int? playlistId;
  bool? isInPaidPlaylist;
  Content? content;
  int? likesAmount;
  Price? price;
  bool? isPaid;
  int? salesAmount;
  int? id;
  DateTime? dateCreated;

  String? appleInAppPurchaseKey;
  String? googleInAppPurchaseKey;

  bool get isBought {
    return isPaid == true && (store.state.user!.saleIds?.videos?.any((x) => x.entityId == id) ?? false);
  }

  bool get isLiked {
    return store.state.user!.likeIds?.videos?.any((x) => x.entityId == id) ?? false;
  }

  bool get isFavorite {
    return store.state.user!.favoriteIds?.videos?.any((x) => x.entityId == id) ?? false;
  }

  bool get isInPreferredLanguage {
    return store.state.settings!.culture == content?.culture;
  }

  Video(
      {this.playlistId,
      this.isInPaidPlaylist,
      this.content,
      this.likesAmount,
      this.price,
      this.isPaid,
      this.salesAmount,
      this.id,
      this.dateCreated});

  Video.fromJson(Map<String, dynamic> json) {
    playlistId = json['playlistId'];
    isInPaidPlaylist = json['isInPaidPlaylist'];
    content =
        json['content'] != null ? new Content.fromJson(json['content']) : null;
    likesAmount = json['likesAmount'];
    price = json['price'] != null ? new Price.fromJson(json['price']) : null;
    isPaid = json['isPaid'];
    salesAmount = json['salesAmount'];
    id = json['id'];
    dateCreated = DateTime.parse(json['dateCreated']);
    appleInAppPurchaseKey = json['appleInAppPurchaseKey'];
    googleInAppPurchaseKey = json['googleInAppPurchaseKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['playlistId'] = this.playlistId;
    data['isInPaidPlaylist'] = this.isInPaidPlaylist;
    if (this.content != null) {
      data['content'] = this.content?.toJson();
    }
    data['likesAmount'] = this.likesAmount;
    if (this.price != null) {
      data['price'] = this.price?.toJson();
    }
    data['isPaid'] = this.isPaid;
    data['salesAmount'] = this.salesAmount;
    data['id'] = this.id;
    data['dateCreated'] = this.dateCreated.toString();
    data['appleInAppPurchaseKey'] = appleInAppPurchaseKey;
    data['googleInAppPurchaseKey'] = googleInAppPurchaseKey;
    return data;
  }
}
