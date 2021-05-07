part of models;

class Movie extends IsSalable {
  int? sportId;
  Content? content;
  int? likesAmount;
  bool? isPaid;
  int? salesAmount;
  int? id;
  DateTime? dateCreated;

  @override
  bool get isBought {
    return isPaid == true &&
        (store.state.user?.saleIds?.movies?.any((x) => x.entityId == id) ??
            false);
  }

  bool get isLiked {
    return store.state.user!.likeIds?.movies?.any((x) => x.entityId == id) ??
        false;
  }

  bool get isFavorite {
    return store.state.user!.favoriteIds?.movies
            ?.any((x) => x.entityId == id) ??
        false;
  }

  bool get isInPreferredLanguage {
    return store.state.settings!.culture == content?.culture;
  }

  Movie(
      {this.sportId,
      this.content,
      this.likesAmount,
      this.isPaid,
      this.salesAmount,
      this.id,
      this.dateCreated});

  Movie.fromJson(Map<String, dynamic> json) {
    sportId = json['sportId'];
    content =
        json['content'] != null ? new Content.fromJson(json['content']) : null;
    likesAmount = json['likesAmount'];
    price = json['price'] != null ? new Price.fromJson(json['price']) : null;
    isPaid = json['isPaid'];
    salesAmount = json['salesAmount'];
    id = json['id'];
    dateCreated = DateTime.parse(json['dateCreated']).toLocal();
    appleInAppPurchaseKey = json['appleInAppPurchaseKey'];
    googleInAppPurchaseKey = json['googleInAppPurchaseKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sportId'] = this.sportId;
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
