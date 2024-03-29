import 'dart:io';

import 'package:extreme/helpers/snack_bar_extension.dart';
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/models/main.dart' as Models;
import 'package:extreme/screens/auth_screen/login_email_screen.dart';
import 'package:extreme/screens/auth_screen/signup_screen.dart';
import 'package:extreme/services/pusn_notifications_manager.dart';
import 'package:extreme/services/social_auth.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/store/settings/actions.dart';
import 'package:extreme/store/user/actions.dart';
import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/helpers/app_localizations_helper.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/container_centered_with_max_width.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';
import 'package:extreme/services/api/main.dart' as Api;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    var vid = Models.Image(path: '/static/videos/bg.mp4');
    super.initState();
    _controller = VideoPlayerController.network(vid.path)
      ..initialize().then((_) {
        _controller?.play();
        _controller?.setLooping(true);
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.pause();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var loc = AppLocalizations.of(context)?.withBaseKey('login_screen');
    var theme = Theme.of(context);
    var os = Platform.isAndroid
        ? SocialAuthOS.Android
        : Platform.isIOS
            ? SocialAuthOS.IOS
            : null;

    return ScreenBaseWidget(
        maxWidthAndCenter: false,
        padding: EdgeInsets.all(0),
        builderChild: (context) => Stack(
              children: [
                SizedBox.expand(
                    child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller?.value.size.width ?? 0,
                    height: _controller?.value.size.height ?? 0,
                    child: VideoPlayer(_controller!),
                  ),
                )),
                Container(
                  color: ExtremeColors.base.withOpacity(0.7),
                  child: ContainerCenteredWithMaxWidth(
                    child: Column(children: <Widget>[
                      Container(
                          height: MediaQuery.of(context).size.height / 4,
                          alignment: Alignment.bottomCenter,
                          child: Image.asset(
                            'assets/images/logo_big.png',
                            width: MediaQuery.of(context).size.width / 2,
                          )),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: Indents.xl),
                        padding: EdgeInsets.symmetric(horizontal: Indents.xl),
                        child: Column(
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.only(bottom: Indents.md),
                                child: Text(
                                  loc!.translate('header'),
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.headline5?.merge(
                                      TextStyle(fontWeight: FontWeight.w500)),
                                )),
                            Text(loc.translate('description'),
                                textAlign: TextAlign.center,
                                style: theme.textTheme.subtitle1?.merge(
                                    TextStyle(fontWeight: FontWeight.w400)))
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                        padding: EdgeInsets.symmetric(horizontal: Indents.xl),
                        child: ScrollConfiguration(
                          behavior: MyBehavior(),
                          child: ListView(
                            children: <Widget>[
                              for (var item in SocialAuthService.all)
                                AuthMethodTypeButton(
                                  service: item,
                                  onPressed: () async {
                                    var token = await item.getToken();
                                    print("TOOOOOOOOOKKKKKK" + token.toString());
                                    await _authWithSocial(
                                        context, item.socialAccount, token!);
                                  },
                                ),
                              // if (!Platform.isIOS)
                              //   AuthMethodTypeButton(
                              //     color: Color(0xff4A76A8),
                              //     name: 'VK',
                              //     svgPath: 'vk',
                              //     onPressed: () async {
                              //       var vkAuth = VkAuthService();
                              //       var token = await vkAuth.getToken();
                              //       await _authWithSocial(context,
                              //           Models.SocialAccountProvider.vk, token);
                              //     },
                              //   ),
                              // AuthMethodTypeButton(
                              //   color: Color(0xff4267B2),
                              //   name: 'Facebook',
                              //   svgPath: 'fb',
                              //   iconSize: 18,
                              //   onPressed: () async {
                              //     var fbAuth = FacebookAuthService();
                              //     var token = await fbAuth.getToken();
                              //     await _authWithSocial(
                              //         context,
                              //         Models.SocialAccountProvider.facebook,
                              //         token);
                              //   },
                              // ),
                              // if (!Platform.isIOS)
                              //   AuthMethodTypeButton(
                              //     color: Color(0xffffffff),
                              //     name: 'Google',
                              //     svgPath: 'google',
                              //     iconSize: 20,
                              //     onPressed: () async {
                              //       var googleAuth = GoogleAuthService();
                              //       var token = await googleAuth.getToken();
                              //       await _authWithSocial(
                              //           context,
                              //           Models.SocialAccountProvider.google,
                              //           token);
                              //     },
                              //   ),
                              AuthMethodTypeButton(
                                color: Color(0xffffffff).withOpacity(0.5),
                                name: 'Email',
                                icon: Icons.alternate_email,
                                iconSize: 20,
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          LoginEmailScreen()));
                                },
                              )
                            ],
                          ),
                        ),
                      )
                    ]),
                  ),
                ),
              ],
            ));
  }

  Future _authWithSocial(BuildContext context,
      Models.SocialAccountProvider provider, String token) async {
    if (token == null) {
      var socialName =
          provider.name![0].toUpperCase() + provider.name!.substring(1);
      Scaffold.of(context).showSnackBar(SnackBarExtension.error(
          'Ошибка при получении данных от $socialName'));
      return;
    }
    var user = await Api.Authentication.loginSocial(provider, token);
    if (user == null) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              SignUpScreen(token: token, accountProvider: provider)));
      return;
    }

    store.dispatch(SetUser(user));
    store.dispatch(
        SetSettings(culture: user.culture!, currency: user.currency!));
    Navigator.of(context, rootNavigator: true).pushNamed('/main');
    await PushNotificationsManager.init();
  }
}

class AuthMethodTypeButton extends StatelessWidget {
  const AuthMethodTypeButton(
      {Key? key,
      this.iconSize,
      this.icon,
      this.onPressed,
      this.service,
      this.name,
      this.color,
      this.bottomIndent = true})
      : super(key: key);

  final bool? bottomIndent;
  final double? iconSize;
  final IconData? icon;
  final VoidCallback? onPressed;
  final SocialAuthService? service;
  final Color? color;
  final String? name;

  @override
  Widget build(BuildContext context) {
    var os = Platform.isAndroid
        ? SocialAuthOS.Android
        : Platform.isIOS
            ? SocialAuthOS.IOS
            : null;
    if (service?.hideFor.contains(os) ?? false) return Container();

    var loc = AppLocalizations.of(context)?.withBaseKey('login_screen');
    var _name = service?.socialAccount.displayName ?? name;
    var _color = service?.color ?? color;
    var svgPath = service?.socialAccount.iconPath;
    var prependText = loc!.translate('sign_in', [_name ?? '']);
    var _iconSize = service?.socialAccount.iconSize ?? iconSize;

    var theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.only(bottom: !(bottomIndent ?? true) ? 0 : Indents.sm),
      child: FlatButton(
        splashColor: (_color == Color(0xffffffff) ? Colors.grey : Colors.white)
            .withOpacity(0.2),
        padding:
            EdgeInsets.symmetric(horizontal: Indents.xl, vertical: Indents.md),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 30,
              margin: EdgeInsets.only(right: Indents.md),
              child: icon == null
                  ? SvgPicture.asset(
                      svgPath ?? '',
                      height: _iconSize,
                    )
                  : Icon(
                      icon,
                      size: _iconSize,
                      color: _color == Color(0xffffffff)
                          ? Colors.grey
                          : Colors.white,
                    ),
            ),
            Flexible(
              child: Text(prependText,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                  style: theme.textTheme.subtitle1?.merge(TextStyle(
                      color: _color == Color(0xffffffff)
                          ? Colors.grey[600]
                          : Colors.white))),
            ),
          ],
        ),
        onPressed: () {
          onPressed?.call();
        },
        color: _color,
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
