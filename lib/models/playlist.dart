import 'package:extreme/models/api_image.dart';

class Playlist{
  int id;
  List<int> videosIds;
  Content content;
}
class Content {
  String name;
  String description;
  ApiImage image;
}