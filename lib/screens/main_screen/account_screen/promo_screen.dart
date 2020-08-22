import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/models/main.dart';
import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
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
  PromoCode _promoCode;

  @override
  Widget build(BuildContext context) {
    var loc = AppLocalizations.of(context).withBaseKey('promo_screen');

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
                                  'Промокод введен',
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
                                          onPressed: () async {
                                            if (_formKey.currentState
                                                .validate()) {
                                              var promoCode = await Api.PromoCode.info(_promoCodeController.text);
                                              if(promoCode != null) {
                                                _promoCodeFocusNode.unfocus();
                                                setState(() {
                                                  _promoCode = promoCode;
                                                  _promoCodeSuccess = true;
                                                });
                                              }
                                            }
                                          }),
                                      icon: Icon(Icons.local_activity),
                                      labelText: 'Введите промокод'),
                                )
                              ]))),
              _promoCodeSuccess ? BlockBaseWidget(
                header: 'Вы получите',
                child: Column(
                  children: <Widget>[
                    _promoCode.subscriptionPlan != null ?
                        SubscriptionCard(model: _promoCode.subscriptionPlan, isForFree: true,)
                        : Container()
                  ],
                ),
              ) : Container()
        ]);
  }
}
