import 'package:extreme/helpers/helper_methods.dart';
import 'package:extreme/helpers/snack_bar_extension.dart';
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/screens/payment_screen.dart';
import 'package:extreme/screens/sport_screen.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/store/user/actions.dart';
import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/custom_future_builder.dart';
import 'package:extreme/widgets/custom_list_builder.dart';
import 'package:extreme/widgets/favorite_toggler.dart';
import 'package:extreme/helpers/app_localizations_helper.dart';
import 'package:extreme/widgets/pay_card.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:extreme/widgets/movie_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_vk_login/generated/i18n.dart';
import 'package:vimeoplayer/vimeoplayer.dart';
import 'package:extreme/models/main.dart' as Models;
import 'package:extreme/services/api/main.dart' as Api;

/// Создаёт экран просмотра видео

class MovieViewScreen extends StatelessWidget {
  final Models.Movie model;

  MovieViewScreen({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context).withBaseKey('video_view_screen');
    var splits = model.content?.url?.split('/') ?? null;
    final id = splits != null ? splits[splits.length - 1] : null;
    return StoreConnector<AppState, Models.User>(
        converter: (store) => store.state.user,
        builder: (context, state) => ScreenBaseWidget(
              padding:
                  EdgeInsets.only(bottom: ScreenBaseWidget.screenBottomIndent),
              appBar: AppBar(
                actions: <Widget>[],
              ),
              builder: (context) => <Widget>[
                if (!model.isPaid || model.isBought)
                  VimeoPlayer(id: id ?? '395212534')
                else if (model.isPaid && !model.isBought)
                  BlockBaseWidget(
                    margin: EdgeInsets.only(top: Indents.md),
                    child: PayCard(
                      price: model.price,
                      isBought: model.isBought,
                      onBuy: () async {
                        var url = await Api.Sale.getPaymentUrl(model.id);

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
                                                'payment.app_bar_content', [
                                          HelperMethods.capitalizeString(
                                              AppLocalizations.of(context)
                                                  .translate('base.movie'))
                                        ]),
                                        url: url,
                                        onPaymentDone: () async {
                                          await Api.User.refresh(true, true);
                                          var movie = await Api.Entities
                                              .getById<Models.Movie>(model.id);
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (ctx) =>
                                                      MovieViewScreen(
                                                          model: movie)));
                                          SnackBarExtension.show(
                                              SnackBarExtension.success(
                                                  AppLocalizations.of(context)
                                                      .translate(
                                                          'payment.success_for',
                                                          [
                                                        AppLocalizations.of(
                                                                context)
                                                            .translate(
                                                                'base.movie')
                                                      ]),
                                                  Duration(seconds: 7)));
                                        },
                                        onBrowserClose: () async {
                                          await Api.User.refresh(true, true);
                                        },
                                      )));
                        }
                      },
                    ),
                  )
                else if (model.isPaid)
                  Flexible(
                    child: Container(
                        padding: EdgeInsets.only(
                            top: Indents.md,
                            left: Indents.md,
                            right: Indents.md),
                        child: Row(
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.only(right: Indents.md),
                                child: Icon(
                                  Icons.info,
                                  color: ExtremeColors.primary,
                                )),
                            Flexible(
                              child: Text(
                                loc.translate('is_in_paid_playlist'),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        )),
                  ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomFutureBuilder(
                        future:
                            Api.Entities.getById<Models.Sport>(model.sportId),
                        builder: (data) {
                          return BlockBaseWidget(
                            padding: EdgeInsets.only(
                                top: Indents.md,
                                left: Indents.md,
                                right: Indents.md),
                            header: model?.content?.name ?? 'Название видео',
                            child: InkWell(
                              child: Text(data.content.name,
                                  style: Theme.of(context).textTheme.caption),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      SportScreen(model: data),
                                ));
                              },
                            ),
                          );
                        }),
                    BlockBaseWidget(
                      child: Row(
                        children: [
                          ActionIcon(
                            signText: loc.translate(
                                'like'), //model?.likesAmount.toString() ?? '224''',
                            icon: Icons.thumb_up,
                            iconColor: model.isLiked
                                ? Theme.of(context).colorScheme.secondary
                                : ExtremeColors.base[200],
                            onPressed: () async {
                              var userAction =
                                  await Api.User.toggleLike(model?.id ?? null);
                              if (userAction != null) {
                                StoreProvider.of<AppState>(context)
                                    .dispatch(ToggleLike(userAction));
                              }
                            },
                          ),
                          Container(
                            margin: EdgeInsets.only(right: Indents.lg),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                FavoriteToggler(
                                  id: model.id,
                                  status: model.isFavorite,
                                  size: 45,
                                  noAlign: true,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: Indents.sm),
                                  // Sign below like icon margin
                                  child: Text(
                                    loc.translate('favorite'), //signText,
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .merge(TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ActionIcon(
                              signText: loc.translate("share"),
                              icon: Icons.share,
                              iconColor: ExtremeColors.base[200]),
                        ],
                      ),
                    ),
                    if (model.isBought && model.isPaid)
                      BlockBaseWidget(
                        child: PayCard(
                          isBought: model.isBought,
                          price: model.price,
                          alignment: MainAxisAlignment.start,
                        ),
                      ),
                    BlockBaseWidget(
                      child: Text(
                          model?.content?.description ??
                              'No description provided',
                          style: Theme.of(context).textTheme.bodyText2),
                    ),
                  ],
                ),
                BlockBaseWidget(
                  header: loc.translate('other_movies'),
                  child: CustomFutureBuilder(
                      future: Api.Entities.getById<Models.Sport>(model.sportId),
                      builder: (data) {
                        List movies = data.moviesIds;
                        movies.remove(model.id);
                        return CustomFutureBuilder(
                            future: Api.Entities.getByIds<Models.Movie>(
                                movies),
                            builder: (moviesData) => CustomListBuilder(
                                type: CustomListBuilderTypes.horizontalList,
                                items: moviesData,
                                height: 200,
                                itemBuilder: (item) => MovieCard(
                                      model: item,
                                      aspectRatio: 9 / 16,
                                    )));
                      }),
                )
              ],
            ));
  }
}

/// Создаёт иконку с действием
class ActionIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor; // цвет icon
  final Function onPressed; // функция-обработчик нажатия на icon
  final String signText;

  ActionIcon({this.icon, this.iconColor, this.onPressed, this.signText});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Like
      margin: EdgeInsets.only(right: Indents.lg), // like container margin
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            padding: EdgeInsets.zero,
            alignment: Alignment.centerRight,
            icon: Icon(icon, size: 45, color: iconColor),
            tooltip: 'Placeholder',
            onPressed: onPressed,
          ),
          Container(
            margin:
                EdgeInsets.only(top: Indents.sm), // Sign below like icon margin
            child: Text(
              signText, //signText,
              style: Theme.of(context).textTheme.caption.merge(TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

/// Создаёт виджет описания видео
class MovieDescription extends StatelessWidget {
  final String text; // текст описания
  const MovieDescription({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'RobotoMono',
                fontSize: 16.0,
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
