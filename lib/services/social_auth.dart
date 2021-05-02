import 'dart:ui';

import 'package:extreme/config/env.dart';
import 'package:extreme/models/main.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_login_vk/flutter_login_vk.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class SocialAuthService {
  Color get color;

  Future<String?> getToken();

  List<SocialAuthOS> get hideFor => [];

  SocialAccountProvider get socialAccount;

  static final List<SocialAuthService> all = [
    GoogleAuthService(),
    VkAuthService(),
    FacebookAuthService()
  ];
}

enum SocialAuthOS { IOS, Android }

class GoogleAuthService implements SocialAuthService {
  Color get color => Color(0xffffffff);
  final GoogleSignIn googleSignIn;

  List<SocialAuthOS> get hideFor => [SocialAuthOS.IOS];

  SocialAccountProvider get socialAccount => SocialAccountProvider.google;

  GoogleAuthService() : googleSignIn = GoogleSignIn();

  @override
  Future<String?> getToken() async {
    var result = await googleSignIn.signIn();
    var googleKey = await result!.authentication;
    return googleKey.idToken ?? null;
  }
}

class FacebookAuthService implements SocialAuthService {
  Color get color => Color(0xff4267B2);
  final FacebookLogin facebookLogin;

  List<SocialAuthOS> get hideFor => [];

  SocialAccountProvider get socialAccount => SocialAccountProvider.facebook;

  FacebookAuthService() : facebookLogin = FacebookLogin();

  @override
  Future<String?> getToken() async {
    var result =
        await facebookLogin.logIn(permissions: [FacebookPermission.email]);
    return result.accessToken?.token ?? null;
  }
}

class VkAuthService implements SocialAuthService {
  Color get color => Color(0xff4A76A8);
  final VKLogin vkLogin;
  static final String svgPath = "assets/svg/vk_logo.svg";
  static final double size = 17;

  List<SocialAuthOS> get hideFor => [SocialAuthOS.IOS];

  SocialAccountProvider get socialAccount => SocialAccountProvider.vk;

  VkAuthService() : vkLogin = VKLogin();

  @override
  Future<String?> getToken() async {
    await vkLogin.initSdk(config!.VK_APP_ID);
    var result = await vkLogin.logIn(scope: [VKScope.email]);
    if (result.isValue) {} else return result.asValue?.value.accessToken?.token ?? null;
  }
}
