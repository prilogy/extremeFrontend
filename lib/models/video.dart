import 'package:extreme/models/api_image.dart';

class Video {
  int id;
  bool isInPaidPlayList;
  Content content;
}

class Content {
  String name;
  String description;
  ApiImage image;
  String url;
}