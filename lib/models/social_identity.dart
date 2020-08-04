part of models;

class SocialIdentity {
  String email;
  String name;
  int socialAccountId;
  String socialAccountKey;

  SocialIdentity(
      {this.email, this.name, this.socialAccountId, this.socialAccountKey});

  SocialIdentity.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    socialAccountId = json['socialAccountId'];
    socialAccountKey = json['socialAccountKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['socialAccountId'] = this.socialAccountId;
    data['socialAccountKey'] = this.socialAccountKey;
    return data;
  }
}