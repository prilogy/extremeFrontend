part of models;

class SocialAccount {
  int? id;
  String? key;
  SocialAccountProvider? provider;

  SocialAccount({this.id, this.key, this.provider});

  SocialAccount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    provider = json['provider'] != null
        ? new SocialAccountProvider.fromJson(json['provider'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    if (this.provider != null) {
      data['provider'] = this.provider?.toJson();
    }
    return data;
  }
}

class SocialAccountProvider {
  int? id;
  String? name;
  String? displayName;
  String? iconPath;
  double? iconSize ;

  SocialAccountProvider(
      {this.id, this.name, this.displayName, this.iconPath, this.iconSize = 16.0});

  SocialAccountProvider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['iconSize'] = this.iconSize;
    data['iconPath'] = this.iconPath;
    return data;
  }

  static final vk = SocialAccountProvider(
      name: 'vk', displayName: 'VK', iconPath: 'assets/svg/vk_logo.svg');
  static final facebook = SocialAccountProvider(
      name: 'facebook',
      displayName: 'Facebook',
      iconSize: 19.0,
      iconPath: 'assets/svg/fb_logo.svg');
  static final google = SocialAccountProvider(
      name: 'google',
      iconSize: 20.0,
      displayName: 'Google',
      iconPath: 'assets/svg/google_logo.svg');

  static final List<SocialAccountProvider> all = [vk, facebook, google];

  bool operator ==(dynamic other) =>
      other != null &&
      other is SocialAccountProvider &&
      this.name == other.name;

  @override
  int get hashCode => super.hashCode;
}
