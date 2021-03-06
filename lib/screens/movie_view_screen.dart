import 'package:extreme/helpers/helper_methods.dart';
import 'package:extreme/helpers/snack_bar_extension.dart';
import 'package:extreme/helpers/vimeo_helpers.dart';
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
import 'package:extreme/widgets/movie_card.dart';
import 'package:extreme/widgets/is_salable_pay_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:extreme/models/main.dart' as Models;
import 'package:extreme/services/api/main.dart' as Api;
import 'package:vimeoplayer/vimeoplayer.dart';

/// Создаёт экран просмотра видео

class MovieViewScreen extends StatefulWidget {
  final Models.Movie model;

  MovieViewScreen({Key? key, required this.model}) : super(key: key);

  @override
  _MovieViewScreenState createState() => _MovieViewScreenState();
}

class _MovieViewScreenState extends State<MovieViewScreen> {
  @override
  void dispose() {
    SystemChrome.restoreSystemUIOverlays();
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)?.withBaseKey('video_view_screen');

    return StoreConnector<AppState, Models.User>(
        converter: (store) => store.state.user!,
        builder: (context, state) => Scaffold(
            appBar: AppBar(),
            body: ListView(
              children: <Widget>[
                if (widget.model.isPaid == false ||
                    widget.model.isBought == true)
                  VimeoPlayer(
                      autoPlay: true,
                      id: VimeoHelpers.getVimeoIdFromLink(
                              widget.model.content?.url) ??
                          '')
                else if (widget.model.isPaid == true &&
                    widget.model.isBought == false)
                  BlockBaseWidget(
                    margin: EdgeInsets.only(top: Indents.md),
                    child: IsSalablePayCard(
                      model: widget.model,
                      onBuySuccess: () async {
                        var movie = await Api.Entities.getById<Models.Movie>(
                            widget.model.id);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (ctx) => MovieViewScreen(model: movie!)));
                      },
                    ),
                  ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomFutureBuilder<Models.Sport?>(
                        future: Api.Entities.getById<Models.Sport>(
                            widget.model.sportId),
                        builder: (data) {
                          return BlockBaseWidget(
                            padding: EdgeInsets.only(
                                top: Indents.md,
                                left: Indents.md,
                                right: Indents.md),
                            header:
                                widget.model.content?.name ?? 'Название видео',
                            child: InkWell(
                              child: Text(data!.content!.name ?? '',
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
                            signText: loc!.translate('like'),
                            //widget.model?.likesAmount.toString() ?? '224''',
                            icon: Icons.thumb_up,
                            iconColor: widget.model.isLiked == true
                                ? Theme.of(context).colorScheme.secondary
                                : ExtremeColors.base[200]!,
                            onPressed: () async {
                              var userAction = await Api.User.toggleLike(
                                  widget.model.id ?? null);
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
                                  id: widget.model.id,
                                  status: widget.model.isFavorite,
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
                                        ?.merge(TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          /*ActionIcon(
                              signText: loc!.translate("share"),
                              icon: Icons.share,
                              iconColor: ExtremeColors.base[200]),
                        */
                        ],
                      ),
                    ),
                    if (widget.model.isBought && widget.model.isPaid == true)
                      BlockBaseWidget(
                        child: IsSalablePayCard(
                          model: widget.model,
                          alignment: MainAxisAlignment.start,
                        ),
                      ),
                    BlockBaseWidget(
                      child: Text(
                          widget.model.content?.description ??
                              'No description provided',
                          style: Theme.of(context).textTheme.bodyText2),
                    ),
                  ],
                ),
                BlockBaseWidget.forScrollingViews(
                  header: loc.translate('other_movies'),
                  margin: EdgeInsets.all(0),
                  child: CustomFutureBuilder<Models.Sport?>(
                      future: Api.Entities.getById<Models.Sport>(
                          widget.model.sportId),
                      builder: (data) {
                        List<int> movies = data!.moviesIds!;
                        movies.remove(widget.model.id);
                        return CustomFutureBuilder<List<Models.Movie>?>(
                            future: Api.Entities.getByIds<Models.Movie>(movies),
                            builder: (moviesData) => CustomListBuilder(
                                type: CustomListBuilderTypes.horizontalList,
                                items: moviesData,
                                height: 230,
                                itemBuilder: (item) => MovieCard(
                                      model: item as Models.Movie,
                                      aspectRatio: 9 / 16,
                                    )));
                      }),
                )
              ],
            )));
  }
}

/// Создаёт иконку с действием
class ActionIcon extends StatelessWidget {
  final IconData? icon;
  final Color? iconColor; // цвет icon
  final Function? onPressed; // функция-обработчик нажатия на icon
  final String? signText;

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
            onPressed: () {
              onPressed?.call();
            },
          ),
          Container(
            margin:
                EdgeInsets.only(top: Indents.sm), // Sign below like icon margin
            child: Text(
              signText ?? '', //signText,
              style: Theme.of(context).textTheme.caption?.merge(TextStyle(
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
class VideoDescription extends StatelessWidget {
  final String? text; // текст описания
  const VideoDescription({Key? key, this.text}) : super(key: key);

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
              text ?? '',
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
