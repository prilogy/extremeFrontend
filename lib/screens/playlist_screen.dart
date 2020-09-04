import 'package:extreme/helpers/helper_methods.dart';
import 'package:extreme/helpers/snack_bar_extension.dart';
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/helpers/app_localizations_helper.dart';
import 'package:extreme/screens/payment_screen.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/custom_future_builder.dart';
import 'package:extreme/widgets/custom_list_builder.dart';
import 'package:extreme/widgets/favorite_toggler.dart';
import 'package:extreme/widgets/hint_chips.dart';
import 'package:extreme/widgets/pay_card.dart';
import 'package:extreme/widgets/playlist_card.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../widgets/stats.dart';
import '../widgets/video_card.dart';
import 'package:extreme/services/api/main.dart' as Api;
import 'package:extreme/models/main.dart' as Models;

/// Создаёт экран просмотра плейлиста

class PlaylistScreen extends StatelessWidget {
  final Models.Playlist model;

  PlaylistScreen({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context).withBaseKey('playlist_screen');

    return StoreConnector<AppState, Models.User>(
        converter: (store) => store.state.user,
        builder: (context, state) => ScreenBaseWidget(
              padding:
                  EdgeInsets.only(bottom: ScreenBaseWidget.screenBottomIndent),
              appBar: AppBar(
                title: Text(model?.content?.name ?? 'Название плейлиста'),
                actions: <Widget>[
                  FavoriteToggler(
                    id: model?.id,
                    status: model?.isFavorite,
                    noAlign: true,
                    size: 24,
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true)
                          .pushNamed('/search');
                    },
                  ),
                ],
              ),
              builder: (context) => <Widget>[
                HeaderPlaylist(model: model),
                model.isPaid
                    ? BlockBaseWidget(
                        child: PayCard(
                          price: model.price,
                          isBought: model.isBought,
                          onBuy: () async {
                            var url =
                                await Api.Sale.getPaymentUrl(model.id);

                            if (url == null) {
                              SnackBarExtension.show(SnackBarExtension.error(
                                  AppLocalizations.of(context)
                                      .translate('payment.error')));
                            } else {
                              Navigator.of(context, rootNavigator: true)
                                  .push(MaterialPageRoute(
                                      builder: (ctx) => PaymentScreen(
                                            title: AppLocalizations.of(context)
                                                .translate(
                                                'payment.app_bar_content', [HelperMethods.capitalizeString(AppLocalizations.of(context).translate('base.playlist'))]),
                                            url: url,
                                            onPaymentDone: () async {
                                              await Api.User.refresh(
                                                  true, true);
                                              SnackBarExtension.show(
                                                  SnackBarExtension.success(
                                                      AppLocalizations.of(context)
                                                          .translate(
                                                          'payment.success_for', [AppLocalizations.of(context).translate('base.playlist')]),
                                                      Duration(seconds: 7)));
                                            },
                                            onBrowserClose: () async {
                                              await Api.User.refresh(
                                                  true, true);
                                            },
                                          )));
                            }
                          },
                        ),
                      )
                    : Container(),
                BlockBaseWidget(
                  header: loc.translate("videos"),
                  child: CustomFutureBuilder<List<Models.Video>>(
                      future:
                          Api.Entities.getByIds<Models.Video>(model.videosIds),
                      builder: (data) => CustomListBuilder(
                          items: data,
                          itemBuilder: (item) =>
                              VideoCard(aspectRatio: 16 / 9, model: item))),
                ),
                BlockBaseWidget.forScrollingViews(
                  header: loc.translate("see_also"),
                  child: CustomFutureBuilder<List<Models.Playlist>>(
                      future:
                          Api.Entities.getAll<Models.Playlist>(1, 5, 'desc'),
                      builder: (data) => CustomListBuilder(
                          type: CustomListBuilderTypes.horizontalList,
                          height: 100,
                          items: data,
                          itemBuilder: (item) => PlayListCard(
                                model: item,
                                aspectRatio: 16 / 9,
                                small: true,
                              ))),
                )
              ],
            ));
  }
}

/// Карточка плейлиста в самом верху страницы
class HeaderPlaylist extends StatelessWidget {
  final Models.Playlist model;

  HeaderPlaylist({this.model});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Stack(
      children: <Widget>[
        Container(
            height: MediaQuery.of(context).size.height / 3,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(model?.content?.image?.path ??
                      'https://img3.akspic.ru/image/20093-parashyut-kaskader-kuala_lumpur-vozdushnye_vidy_sporta-ekstremalnyj_vid_sporta-1920x1080.jpg')),
            ),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [
                    0,
                    0.8,
                    1
                  ],
                      colors: [
                    theme.colorScheme.background.withOpacity(0),
                    theme.colorScheme.background.withOpacity(1),
                    theme.colorScheme.background.withOpacity(1),
                  ])),
            )),
        Positioned.fill(
          bottom: Indents.md,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: Indents.sm),
                    child: Text(
                        model?.content?.name ??
                            "Название плейлиста лалал лалала лала алала лалал ал аа лал ",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5.merge(
                            TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.25))),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: Indents.sm),
                    child: Text(
                        model?.content?.description ??
                            "Описание данного плейлиста",
                        style: Theme.of(context).textTheme.bodyText2),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Stats(
                        icon: Icons.thumb_up,
                        text: model.likesAmount.toString(),
                        marginBetween: 5,
                      ),
                      Stats(
                        icon: Icons.local_movies,
                        text: (model.videosIds?.length ?? 0).toString(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        model.isInPreferredLanguage
            ? Container()
            : HintChip.noLocalization(margin: EdgeInsets.only(left: Indents.sm))
      ],
    );
  }
}
