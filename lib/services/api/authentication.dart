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
      {String name,
      String email,
      String password,
      String dateBirthday,
      String phoneNumber,
      File avatar}) async {
    var form = FormData.fromMap({
      "name": name,
      "email": email,
      "password": password,
      "dateBirthday": dateBirthday,
      "phoneNumber": phoneNumber,
      "avatar": await MultipartFile.fromFile(
        avatar.path,
        filename: avatar.path.split('/').last,
      ),
    });

    try {
      var response = await dio.put('/auth/signUp', data: form);
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

  static Future<bool> signUpSocial(
      Models.SocialAccountProvider provider,
      Models.SocialIdentity identity,
      String name,
      String email,
      String password,
      String dateBirthday,
      String phoneNumber,
      File avatar) async {
    try {
      var form = FormData.fromMap({
        "name": name,
        "email": email,
        "password": password,
        "dateBirthday": dateBirthday,
        "phoneNumber": phoneNumber,
        "avatar": await MultipartFile.fromFile(
          avatar.path,
          filename: avatar.path.split('/').last,
        ),
        "socialAccountId": identity.socialAccountId,
        "socialAccountKey": identity.socialAccountKey
      });

      var response = await dio
          .put('/auth/signup/${provider.name}', data: form);

      return true;
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
