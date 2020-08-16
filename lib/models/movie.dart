part of models;

class Movie {
  int sportId;
  Content content;
  int likesAmount;
  Price price;
  bool isPaid;
  int salesAmount;
  int id;
  DateTime dateCreated;
  bool get isFavorite {
    return store.state.user?.favoriteIds?.movies?.contains(id) ?? false;
  }

  Movie(
      {this.sportId,
      this.content,
      this.likesAmount,
      this.price,
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sportId'] = this.sportId;
    if (this.content != null) {
      data['content'] = this.content.toJson();
    }
    data['likesAmount'] = this.likesAmount;
    if (this.price != null) {
      data['price'] = this.price.toJson();
    }
    data['isPaid'] = this.isPaid;
    data['salesAmount'] = this.salesAmount;
    data['id'] = this.id;
    data['dateCreated'] = this.dateCreated.toString();
    return data;
  }
}
