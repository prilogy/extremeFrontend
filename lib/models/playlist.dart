import 'package:extreme/models/api_image.dart';

class Playlist{
  int id;
  List<int> videosIds;
  Content content;

Playlist({this.id, this.videosIds, this.content});
  factory Playlist.fromJson(Map<String,dynamic> json){
    print('decoding, id is ' + json['playlists'][0]['videosIds'].toString());
    print(json['playlists'][0]['videosIds'][0] + json['playlists'][0]['videosIds'][1]);
    return Playlist(
      id: json['playlists'][0]['id'],
      // videosIds: json['playlits'][0]['videosIds'],
     // content: json['playlists'][0]['content'],
    );
  }
}
class Content {
  String name;
  String description;
  ApiImage image;
}