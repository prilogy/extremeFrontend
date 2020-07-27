part of models;

class Content {
  Image image;
  Culture culture;
  String name;
  String description;
  String url;

  Content({this.image, this.culture, this.name, this.description, this.url});

  Content.fromJson(Map<String, dynamic> json) {
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    culture =
    json['culture'] != null ? new Culture.fromJson(json['culture']) : null;
    name = json['name'];
    description = json['description'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.image != null) {
      data['image'] = this.image.toJson();
    }

    this.image?.toJson();

    if (this.culture != null) {
      data['culture'] = this.culture.toJson();
    }
    data['name'] = this.name;
    data['description'] = this.description;
    data['url'] = this.url;
    return data;
  }
}