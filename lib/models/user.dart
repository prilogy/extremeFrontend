part of models;

class User {
  List<SocialAccount> socialAccounts;
  Culture culture;
  Currency currency;
  int id;
  String email;
  String name;
  DateTime dateBirthday;
  DateTime dateSignUp;
  String phoneNumber;
  _Subscription subscription;
  bool emailVerified;
  String token;

  _LikeIds likeIds;
  _FavoriteIds favoriteIds;
  _SaleIds saleIds;

  static const String localStorageKey = 'user';
  
  User(
      {this.socialAccounts,
        this.culture,
        this.currency,
        this.id,
        this.email,
        this.name,
        this.dateBirthday,
        this.dateSignUp,
        this.phoneNumber,
        this.subscription,
        this.emailVerified,
        this.likeIds,
        this.favoriteIds,
        this.saleIds,
        this.token});
  
  static User fromLocalStorage() {
    try {
      var json = localStorage.getItem(localStorageKey);
      return json == null ? null : User.fromJson(json);
    } catch(ex) {
      return null;
    }
  }

  static void saveToLocalStorage(User user) {
    localStorage.setItem(localStorageKey, user?.toJson() ?? null);
  }

  User.fromJson(Map<String, dynamic> json) {
    if (json['socialAccounts'] != null) {
      socialAccounts = new List<SocialAccount>();
      json['socialAccounts'].forEach((v) {
        socialAccounts.add(new SocialAccount.fromJson(v));
      });
    }
    culture =
    json['culture'] != null ? new Culture.fromJson(json['culture']) : null;
    currency = json['currency'] != null
        ? new Currency.fromJson(json['currency'])
        : null;
    id = json['id'];
    email = json['email'];
    name = json['name'];
    dateBirthday = DateTime.parse(json['dateBirthday']).toLocal();
    dateSignUp = DateTime.parse(json['dateSignUp']).toLocal();
    phoneNumber = json['phoneNumber'];
    subscription = json['subscription'] != null
        ? new _Subscription.fromJson(json['subscription'])
        : null;
    emailVerified = json['emailVerified'];
    likeIds =
    json['likeIds'] != null ? new _LikeIds.fromJson(json['likeIds']) : null;
    favoriteIds = json['favoriteIds'] != null
        ? new _FavoriteIds.fromJson(json['favoriteIds'])
        : null;
    saleIds =
    json['saleIds'] != null ? new _SaleIds.fromJson(json['saleIds']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.socialAccounts != null) {
      data['socialAccounts'] =
          this.socialAccounts.map((v) => v.toJson()).toList();
    }
    if (this.culture != null) {
      data['culture'] = this.culture.toJson();
    }
    if (this.currency != null) {
      data['currency'] = this.currency.toJson();
    }
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['dateBirthday'] = this.dateBirthday.toString();
    data['dateSignUp'] = this.dateSignUp.toString();
    data['phoneNumber'] = this.phoneNumber;
    if (this.subscription != null) {
      data['subscription'] = this.subscription.toJson();
    }
    data['emailVerified'] = this.emailVerified;
    if (this.likeIds != null) {
      data['likeIds'] = this.likeIds.toJson();
    }
    if (this.favoriteIds != null) {
      data['favoriteIds'] = this.favoriteIds.toJson();
    }
    if (this.saleIds != null) {
      data['saleIds'] = this.saleIds.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class SocialAccount {
  int id;
  String key;
  SocialAccountProvider provider;

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
      data['provider'] = this.provider.toJson();
    }
    return data;
  }
}

class SocialAccountProvider {
  int id;
  String name;

  SocialAccountProvider({this.id, this.name});

  SocialAccountProvider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }

  static final Vk = SocialAccountProvider(name: 'vk');
  static final Facebook = SocialAccountProvider(name: 'facebook');
  static final Google = SocialAccountProvider(name: 'google');
}


class _Subscription {
  DateTime dateEnd;

  _Subscription({this.dateEnd});

  _Subscription.fromJson(Map<String, dynamic> json) {
    dateEnd = DateTime.parse(json['dateEnd']).toLocal();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dateEnd'] = this.dateEnd.toString();
    return data;
  }
}

class _LikeIds {
  List<int> videos;
  List<int> movies;

  _LikeIds({this.videos, this.movies});

  _LikeIds.fromJson(Map<String, dynamic> json) {
    videos = json['videos'].cast<int>();
    movies = json['movies'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['videos'] = this.videos;
    data['movies'] = this.movies;
    return data;
  }
}

class _FavoriteIds {
  List<int> videos;
  List<int> movies;
  List<int> sports;
  List<int> playlists;

  _FavoriteIds({this.videos, this.movies, this.sports, this.playlists});

  _FavoriteIds.fromJson(Map<String, dynamic> json) {
    videos = json['videos'].cast<int>();
    movies = json['movies'].cast<int>();
    sports = json['sports'].cast<int>();
    playlists = json['playlists'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['videos'] = this.videos;
    data['movies'] = this.movies;
    data['sports'] = this.sports;
    data['playlists'] = this.playlists;
    return data;
  }
}

class _SaleIds {
  List<int> videos;
  List<int> movies;
  List<int> playlists;

  _SaleIds({this.videos, this.movies, this.playlists});

  _SaleIds.fromJson(Map<String, dynamic> json) {
    videos = json['videos'].cast<int>();
    movies = json['movies'].cast<int>();
    playlists = json['playlists'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['videos'] = this.videos;
    data['movies'] = this.movies;
    data['playlists'] = this.playlists;
    return data;
  }
}
