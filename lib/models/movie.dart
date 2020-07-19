import 'package:extreme/models/api_image.dart';

class Movie {
  int id;
  Content content;
}
class Content {
  String name;
  String description;
  ApiImage image;

  String url;
}