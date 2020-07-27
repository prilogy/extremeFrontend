part of models;

class Video {
  int id;
  bool isInPaidPlayList;
  Content content;
  Video({this.content, this.isInPaidPlayList, this.id});
  factory Video.fromJson(Map<String,dynamic> json){
    return Video(
      id: json['id'],
      isInPaidPlayList: json['videosIds'],
      content: json['content'],
    );
  }
}