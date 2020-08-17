part of models;

class Sport {
  List<int> playlistsIds;
  List<int> moviesIds;
  Content content;
  int id;
  DateTime dateCreated;
  bool get isFavorite {
    return store.state.user?.favoriteIds?.sports?.contains(id) ?? false;
  }

  Sport(
      {this.playlistsIds,
      this.moviesIds,
      this.content,
      this.id,
      this.dateCreated});

  Sport.fromJson(Map<String, dynamic> json) {
    playlistsIds = json['playlistsIds']?.cast<int>() ?? [];
    moviesIds = json['moviesIds']?.cast<int>() ?? [];
    content =
        json['content'] != null ? new Content.fromJson(json['content']) : null;
    id = json['id'];
    dateCreated = DateTime.parse(json['dateCreated']).toLocal();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['playlistsIds'] = this.playlistsIds;
    data['moviesIds'] = this.moviesIds;
    if (this.content != null) {
      data['content'] = this.content.toJson();
    }
    data['id'] = this.id;
    data['dateCreated'] = this.dateCreated.toString();
    return data;
  }
}
