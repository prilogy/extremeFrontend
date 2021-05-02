part of models;

class Sport {
  List<int>? playlistsIds;
  List<int>? moviesIds;
  Content? content;
  int? id;
  DateTime? dateCreated;
  int? bestPlaylistId;
  int? bestVideoId;

  bool get isFavorite {
    return store.state.user!.favoriteIds?.sports?.any((x) => x.entityId == id) ?? false;
  }

  bool get isInPreferredLanguage {
    return store.state.settings!.culture == content?.culture;
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
    bestPlaylistId = json['bestPlaylistId'];
    bestVideoId = json['bestVideoId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['playlistsIds'] = this.playlistsIds;
    data['moviesIds'] = this.moviesIds;
    if (this.content != null) {
      data['content'] = this.content?.toJson();
    }
    data['id'] = this.id;
    data['dateCreated'] = this.dateCreated.toString();
    data['bestPlaylistId'] = this.bestPlaylistId;
    data['bestVideoId'] = this.bestVideoId;
    return data;
  }
}
