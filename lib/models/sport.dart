import 'package:extreme/models/api_image.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Sport {
  int id;
  List<int> playlistsIds;
  List<int> moviesIds;
  Content content;
}

class Content {
  String name;
  String description;
  ApiImage image;
}

