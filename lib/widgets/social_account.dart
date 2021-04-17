import 'dart:io';

import 'package:extreme/helpers/snack_bar_extension.dart';
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/main.dart';
import 'package:extreme/models/main.dart';
import 'package:extreme/services/social_auth.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/services/api/main.dart' as Api;
import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/helpers/app_localizations_helper.dart';
import 'package:extreme/styles/intents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialAccount extends StatelessWidget {
  final SocialAuthService service;

  SocialAccount({this.service});

  @override
  Widget build(BuildContext context) {
    var os = Platform.isAndroid
        ? SocialAuthOS.Android
        : Platform.isIOS
            ? SocialAuthOS.IOS
            : null;
    var model = service.socialAccount;
    var loc = AppLocalizations.of(context).withBaseKey('account_screen');
    if (service.hideFor.contains(os)) return Container();

    return StoreConnector<AppState, User>(
      converter: (store) => store.state.user,
      builder: (context, state) => Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 30,
                margin: EdgeInsets.only(right: Indents.smd),
                child: SvgPicture.asset(
                  model.iconPath,
                  height: 25,
                ),
              ),
              Text(
                model.displayName,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
          RaisedButton(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            textColor: state.socialAccounts.any((x) => x.provider == model)
                ? ExtremeColors.error
                : ExtremeColors.success,
            onPressed: () async {
              var isConnected = state.socialAccounts
                  .any((x) => x.provider.name == model.name);
              if (!isConnected) {
                var token = await service.getToken();

                var result = await Api.User.addSocialAccount(model, token);
                if (result == true) {
                  await Api.User.refresh(true, true);
                  rootScaffold.currentState.showSnackBar(
                      SnackBarExtension.success(loc.translate(
                          'account_connect_success', [model.displayName])));
                } else
                  rootScaffold.currentState.showSnackBar(
                      SnackBarExtension.error(
                          loc.translate('account_connect_error')));
              } else {
                var result = await Api.User.removeSocialAccount(model);
                if (result == true) {
                  await Api.User.refresh(true, true);
                  rootScaffold.currentState.showSnackBar(
                      SnackBarExtension.success(loc.translate(
                          'account_disconnect_success', [model.displayName])));
                }
              }
            },
            child: Text(loc
                .translate(state.socialAccounts.any((x) => x.provider == model)
                    ? 'disconnect'
                    : 'connect')
                .toUpperCase()),
          )
        ],
      )),
    );
  }
}
