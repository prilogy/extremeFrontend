import 'package:extreme/classes/is_salable.dart';
import 'package:extreme/helpers/purchase_manager.dart';
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/models/apple_payment.dart';
import 'package:extreme/services/api/main.dart';
import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/styles/intents.dart';
import 'package:flutter/material.dart';
import 'package:extreme/helpers/app_localizations_helper.dart';
import 'package:flutter_inapp_purchase/modules.dart';

class IsSalablePayCard extends StatefulWidget {
  final IsSalable model;
  final VoidCallback? onBuySuccess;
  final MainAxisAlignment? alignment;

  const IsSalablePayCard(
      {required this.model,
      this.onBuySuccess,
      this.alignment = MainAxisAlignment.spaceAround});

  @override
  _IsSalablePayCardState createState() => _IsSalablePayCardState();
}

class _IsSalablePayCardState extends State<IsSalablePayCard> {
  bool _isLoaded = false;
  IAPItem? _iapItem;

  final PurchaseManager _pManager = PurchaseManager(
      urlGetter: (item) => Sale.getPaymentUrl(item.id!),
      onRefresh: () => User.refresh(true, true));

  @override
  void initState() {
    super.initState();
    asyncInitState();
  }

  void asyncInitState() async {
    final productId = widget.model.productId;
    await _pManager.init(productId != null ? [productId] : []);
    _pManager.onIapSuccess = (model, iap) async {
      final r = await AppleNotification.payment(ApplePayment(
          planId: model?.id, transactionReceipt: iap?.transactionReceipt));
      if (r) widget.onBuySuccess?.call();
      return r;
    };

    setState(() {
      _iapItem = _pManager.iapManager?.productById(productId);
      _isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!.withBaseKey("pay_card").translate;
    final isBought = widget.model.isBought ?? false;
    final price = _iapItem?.localizedPrice ?? widget.model.price.toString();

    _pManager.onSuccessMessage = loc('payment_success');
    _pManager.onErrorMessage =
        AppLocalizations.of(context)!.translate('payment.error');

    return !_isLoaded
        ? CircularProgressIndicator()
        : Row(
            mainAxisAlignment: widget.alignment!,
            children: <Widget>[
              if (!isBought)
                Flexible(
                  child: Container(
                      padding: EdgeInsets.only(right: Indents.md),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              loc('info'),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ),
                        ],
                      )),
                ),
              Column(
                children: <Widget>[
                  !isBought
                      ? Text(
                          price,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.merge(TextStyle(
                                fontSize: 24,
                              )),
                        )
                      : Container(),
                  isBought
                      ? Row(
                          children: <Widget>[
                            Icon(
                              Icons.done,
                              color: ExtremeColors.success,
                            ),
                            Container(
                                margin: EdgeInsets.only(
                                    left: Indents.sm, right: Indents.md),
                                child: Text(
                                  loc('owned'),
                                  style:
                                      TextStyle(color: ExtremeColors.success),
                                ))
                          ],
                        )
                      : ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Theme.of(context).colorScheme.primary)),
                          child: Text(loc('buy')),
                          onPressed: () async {
                            await _pManager.purchase(widget.model,
                                context: context);
                          })
                ],
              ),
            ],
          );
  }
}
