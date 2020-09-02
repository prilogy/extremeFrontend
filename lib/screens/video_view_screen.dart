import 'package:extreme/lang/app_localizations.dart';
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
import 'package:extreme/widgets/video_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vimeoplayer/vimeoplayer.dart';
import 'package:extreme/models/main.dart' as Models;
import 'package:extreme/services/api/main.dart' as Api;

/// Создаёт экран просмотра видео

class VideoViewScreen extends StatelessWidget {
  final Models.Video model;
  VideoViewScreen({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context).withBaseKey('video_view_screen');

    return StoreConnector<AppState, Models.User>(
        converter: (store) => store.state.user,
        builder: (context, state) => ScreenBaseWidget(
              padding:
                  EdgeInsets.only(bottom: ScreenBaseWidget.screenBottomIndent),
              appBar: AppBar(
                title: Text(model?.content?.name ?? 'Название видео'),
                actions: <Widget>[
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
                (state.saleIds.videos.contains(model.id) || !model.isInPaidPlaylist) ? VimeoPlayer(id: '395212534') : PayCard(name: model.content.name, description: model.content.description, price: model.price,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlockBaseWidget(
                      padding: EdgeInsets.only(
                          top: Indents.md, left: Indents.md, right: Indents.md),
                      header: model?.content?.name ?? 'Название видео',
                      child: Text('Название спорта - Плейлист',
                          style: Theme.of(context).textTheme.caption),
                    ),
                    BlockBaseWidget(
                      child: Row(
                        children: [
                          ActionIcon(
                            signText: model?.likesAmount.toString() ?? '224',
                            icon: Icons.thumb_up,
                            iconColor: ExtremeColors.primary,
                            onPressed: () async {
                              var userAction =
                                  await Api.User.toggleLike(model?.id ?? null);
                              if (userAction != null) {
                                StoreProvider.of<AppState>(context)
                                    .dispatch(ToggleLike(userAction));
                              }
                            },
                          ),
                          // ActionIcon(
                          //   signText: 'В избранное',
                          //   icon: Icons.favorite,
                          //   iconColor: ExtremeColors.error,
                          //   onPressed: () async {
                          //     var userAction =
                          //         await Api.User.toggleFavorite(model?.id ?? null);
                          //     if (userAction != null) {
                          //       StoreProvider.of<AppState>(context)
                          //           .dispatch(ToggleLike(userAction));
                          //     }
                          //   },
                          // ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              FavoriteToggler(
                                id: model?.id,
                                size: 45,
                                status: model?.isFavorite,
                              ),
                              Text(loc.translate("favorite")),
                            ],
                          ),
                          ActionIcon(
                              signText: loc.translate("share"),
                              icon: Icons.share,
                              iconColor: ExtremeColors.base[200]),
                        ],
                      ),
                    ),
                    BlockBaseWidget(
                      child: Text(
                          model?.content?.description ??
                              'No description provided',
                          style: Theme.of(context).textTheme.bodyText2),
                    ),
                    BlockBaseWidget(
                        header: loc.translate("other_videos"),
                        child: CustomFutureBuilder(
                            future: Api.Entities.getById<Models.Playlist>(
                                model.playlistId),
                            builder: (Models.Playlist data) {
                              List videosIds = data.videosIds;
                              // Исключение этого же видео из выдачи
                              videosIds.remove(model.id);
                              // Случайная перемешка видео для исключения выдачи одних и тех же видео
                              if (videosIds.length >= 3) {
                                videosIds.shuffle();
                                videosIds = videosIds.sublist(0, 3);
                              }

                              return CustomFutureBuilder(
                                  future: Api.Entities.getByIds<Models.Video>(
                                      videosIds),
                                  builder: (data) => CustomListBuilder(
                                      items: data,
                                      itemBuilder: (item) => VideoCard(
                                            model: item,
                                            aspectRatio: 16 / 9,
                                          )));
                            }))
                  ],
                ),
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
              signText,
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
class VideoDescription extends StatelessWidget {
  final String text; // текст описания
  const VideoDescription({Key key, this.text}) : super(key: key);

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
