import 'package:extreme/helpers/enums.dart';
import 'package:extreme/helpers/helper_methods.dart';
import 'package:extreme/helpers/snack_bar_extension.dart';
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/models/main.dart' as Models;
import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/sample_card.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:extreme/widgets/subsciption_card.dart';
import 'package:flutter/material.dart';
import 'package:extreme/helpers/app_localizations_helper.dart';
import 'package:extreme/services/api/main.dart' as Api;
class PromoScreen extends StatefulWidget {
  @override
  _PromoScreenState createState() => _PromoScreenState();
}

class _PromoScreenState extends State<PromoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _promoCodeController = TextEditingController();
  final _promoCodeFocusNode = FocusNode();

  bool _promoCodeSuccess = false;
  Models.PromoCode _promoCode;
  String _promoCodeValue;

  @override
  Widget build(BuildContext context) {
    var loc = AppLocalizations.of(context).withBaseKey('promo_screen');

    void onSubmit() async {
      if (_formKey.currentState.validate()) {
        var promoCode = await Api.PromoCode.info(_promoCodeController.text);
        if (promoCode != null) {
          _promoCodeValue = _promoCodeController.text;
          _promoCodeFocusNode.unfocus();
          setState(() {
            _promoCode = promoCode;
            _promoCodeSuccess = true;
          });
        } else {
          SnackBarExtension.show(
              SnackBarExtension.error(loc.translate('code_error')));
        }
      }
    }

    return ScreenBaseWidget(
        appBar: AppBar(
          title: Text(loc.translate('app_bar')),
        ),
        builder: (context) => [
              BlockBaseWidget(
                  child: _promoCodeSuccess
                      ? Row(
                          children: <Widget>[
                            Icon(Icons.check_circle_outline,
                                color: ExtremeColors.success),
                            Container(
                                margin: EdgeInsets.only(left: Indents.md),
                                child: Text(
                                  loc.translate('code_success'),
                                  style:
                                      TextStyle(color: ExtremeColors.success),
                                ))
                          ],
                        )
                      : Form(
                          key: _formKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                TextFormField(
                                  onFieldSubmitted: (c) => onSubmit(),
                                  focusNode: _promoCodeFocusNode,
                                  controller: _promoCodeController,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Введите текст самфинг';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                          icon: Icon(Icons.arrow_forward),
                                          onPressed: onSubmit),
                                      icon: Icon(Icons.local_activity),
                                      labelText: loc.translate('enter_code')),
                                )
                              ]))),
              _promoCodeSuccess
                  ? BlockBaseWidget(
                      header: loc.translate('you_get'),
                      child: Column(
                        children: <Widget>[
                          _promoCode.subscriptionPlan != null
                              ? Container(
                                  margin: EdgeInsets.only(bottom: Indents.md),
                                  child: SubscriptionCard(
                                    model: _promoCode.subscriptionPlan,
                                    isForFree: true,
                                  ),
                                )
                              : Container(),
                          () {
                            var type = _promoCode?.entitySaleable != null
                                ? _promoCode.entitySaleable['entityType']
                                : null;
                            if (type == null) return Container();
                            var typeName = HelperMethods.capitalizeString(
                                AppLocalizations.of(context)
                                    .translate('base.$type'));
                            String title;
                            Models.Price price;
                            Models.Image image;
                            switch (type) {
                              case Entities.video:
                                var entity = Models.Video.fromJson(
                                    _promoCode.entitySaleable);
                                title = entity.content.name;
                                price = entity.price;
                                image = entity.content.image;
                                break;
                              case Entities.movie:
                                var entity = Models.Movie.fromJson(
                                    _promoCode.entitySaleable);
                                title = entity.content.name;
                                price = entity.price;
                                image = entity.content.image;
                                break;
                              case Entities.playlist:
                                var entity = Models.Playlist.fromJson(
                                    _promoCode.entitySaleable);
                                title = entity.content.name;
                                price = entity.price;
                                image = entity.content.image;
                                break;
                              default:
                                return Container();
                            }
                            return SampleCard(
                              title: title,
                              body: typeName,
                              image: image,
                              price: price,
                              isForFree: true,
                            );
                          }(),
                          Container(
                            margin: EdgeInsets.only(top: Indents.md),
                            child: SizedBox(
                              width: double.infinity,
                              child: RaisedButton(
                                color: Theme.of(context).primaryColor,
                                onPressed: () async {
                                  var res = await Api.PromoCode.confirm(
                                      _promoCodeValue);
                                  if (res == true) {
                                    await Api.User.refresh(true, true);
                                    SnackBarExtension.show(
                                        SnackBarExtension.success(
                                            loc.translate('redeem_success')));
                                  } else {
                                    SnackBarExtension.show(
                                        SnackBarExtension.error(
                                            loc.translate('redeem_error')));
                                  }
                                  Navigator.of(context).pop();
                                },
                                child:
                                    Text(loc.translate('redeem').toUpperCase()),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : Container()
            ]);
  }
}
