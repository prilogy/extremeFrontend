part of models;

class Image {
  String path;

  Image(String path) {
    this.path = config.API_BASE_URL + path;
  }
}
