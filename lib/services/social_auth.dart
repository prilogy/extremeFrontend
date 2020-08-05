import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class SocialAuthService {
  Future<String> getToken() => null;
}

class GoogleAuthService implements SocialAuthService {
  final GoogleSignIn googleSignIn;

  GoogleAuthService(this.googleSignIn);

  @override
  Future<String> getToken() async {
    var result = await googleSignIn.signIn();
    var googleKey = await result.authentication;
    return googleKey?.idToken ?? null;
  }
}

class FacebookAuthService implements SocialAuthService {
  final FacebookLogin facebookLogin;

  FacebookAuthService(): facebookLogin = FacebookLogin();

  @override
  Future<String> getToken() async {
    var result =  await facebookLogin.logIn(['email']);
    return result?.accessToken?.token ?? null;
  }
}