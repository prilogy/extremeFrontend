part of models;

class SearchResult {
  List<Sport> sports;
  List<Playlist> playlists;
  List<Video> videos;
  List<Movie> movies;

  SearchResult({this.sports, this.playlists, this.videos, this.movies});

  SearchResult.fromJson(Map<String, dynamic> json) {
    if (json['sports'] != null) {
      sports = new List<Sport>();
      json['sports'].forEach((v) {
        sports.add(new Sport.fromJson(v));
      });
    }
    if (json['playlists'] != null) {
      playlists = new List<Playlist>();
      json['playlists'].forEach((v) {
        playlists.add(new Playlist.fromJson(v));
      });
    }
    if (json['videos'] != null) {
      videos = new List<Video>();
      json['videos'].forEach((v) {
        videos.add(new Video.fromJson(v));
      });
    }
    if (json['movies'] != null) {
      movies = new List<Movie>();
      json['movies'].forEach((v) {
        movies.add(new Movie.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sports != null) {
      data['sports'] = this.sports.map((v) => v.toJson()).toList();
    }
    if (this.playlists != null) {
      data['playlists'] = this.playlists.map((v) => v.toJson()).toList();
    }
    if (this.videos != null) {
      data['videos'] = this.videos.map((v) => v.toJson()).toList();
    }
    if (this.movies != null) {
      data['movies'] = this.movies.map((v) => v.toJson()).toList();
    }
    return data;
  }
}