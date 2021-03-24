import 'package:extreme/config/env.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_login_vk/flutter_login_vk.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class SocialAuthService {
  Future<String> getToken() => null;
}

class GoogleAuthService implements SocialAuthService {
  final GoogleSignIn googleSignIn;

  GoogleAuthService(): googleSignIn = GoogleSignIn();

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

class VkAuthService implements SocialAuthService {
  final VKLogin vkLogin;
  static final String svgPath = "assets/svg/vk_logo.svg";
  static final double size = 17;

  VkAuthService() : vkLogin = VKLogin();

  @override
  Future<String> getToken() async {
    await vkLogin.initSdk(config.VK_APP_ID);
    var result = await vkLogin.logIn(scope: [VKScope.email]);
    if (result.isValue) {} else
      print(result.asError);

    var token = result.asValue?.value?.accessToken ?? null;

    return token?.token ?? null;
  }
}