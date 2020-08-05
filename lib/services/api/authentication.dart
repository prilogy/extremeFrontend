part of api;

class Authentication {
  static Future<Models.User> login({String email, String password}) async {
    try {
      var response = await dio
          .post('/auth/login', data: {"email": email, "password": password});

      var user = Models.User.fromJson(response.data);
      print('successful login: /n' + response.data.toString());
      return user;
    } on DioError catch (e) {
      //обработка ошибочных кодов
      print(e.response.statusCode);
      return null;
    }
  }

  /// dateBirthday в виде ДД.ММ.ГГГГ
  static Future<bool> signUp(
      {@required String name,
      @required String email,
      @required String password,
      @required String dateBirthday,
      String phoneNumber,
      File avatar,
      Models.SocialIdentity socialIdentity,
      Models.SocialAccountProvider socialProvider}) async {
    var isSocial = socialIdentity != null && socialProvider != null;
    var map = {
      "name": name,
      "email": email,
      "password": password,
      "phoneNumber": phoneNumber,
      'dateBirthday': dateBirthday,
      "avatar": await MultipartFile.fromFile(
        avatar.path,
        filename: avatar.path.split('/').last,
      ),
    };

    if (isSocial)
      map.addAll({
        "socialAccountId": socialIdentity.socialAccountId,
        "socialAccountKey": socialIdentity.socialAccountKey
      });

    try {
      var response = await dio.put(isSocial? '/auth/signup/${socialProvider.name}' : '/auth/signup', data: FormData.fromMap(map));
      return true;
    } on DioError catch (e) {
      print(e.response.statusCode);
      return false;
    }
  }

  static Future<Models.SocialIdentity> signUpSocialGetInfo(
      Models.SocialAccountProvider provider, String token) async {
    try {
      var response = await dio
          .post('/auth/signup/${provider.name}', data: {'token': token});

      return Models.SocialIdentity.fromJson(response.data);
    } on DioError catch (e) {
      return null;
    }
  }

  static Future<Models.User> loginSocial(
      Models.SocialAccountProvider provider, String token) async {
    try {
      var response = await dio
          .post('/auth/login/${provider.name}', data: {'token': token});
      return Models.User.fromJson(response.data);
    } on DioError catch (e) {
      return null;
    }
  }
}
