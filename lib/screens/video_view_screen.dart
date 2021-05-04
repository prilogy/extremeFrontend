import 'package:extreme/helpers/helper_methods.dart';
import 'package:extreme/helpers/snack_bar_extension.dart';
import 'package:extreme/helpers/vimeo_helpers.dart';
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/screens/payment_screen.dart';
import 'package:extreme/screens/playlist_screen.dart';
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
import 'package:extreme/widgets/video_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:extreme/models/main.dart' as Models;
import 'package:extreme/services/api/main.dart' as Api;
import 'package:url_launcher/url_launcher.dart';
import 'package:vimeoplayer/vimeoplayer.dart';

/// Создаёт экран просмотра видео

class VideoViewScreen extends StatefulWidget {
  final Models.Video model;

  VideoViewScreen({Key? key, required this.model}) : super(key: key);

  @override
  _VideoViewScreenState createState() => _VideoViewScreenState();
}

class _VideoViewScreenState extends State<VideoViewScreen> with AutomaticKeepAliveClientMixin<VideoViewScreen> {
  @override
  bool get wantKeepAlive => true;


  @override
  void dispose() {
    SystemChrome.restoreSystemUIOverlays();
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final loc = AppLocalizations.of(context)?.withBaseKey('video_view_screen');
    final theme = Theme.of(context);
    final isInOwnedPlaylist = widget.model.isInPaidPlaylist!
        ? store.state.user!.saleIds!.playlists!
            .any((x) => x.entityId == widget.model.playlistId)
        : false;

    return StoreConnector<AppState, Models.User>(
        converter: (store) => store.state.user!,
        builder: (context, state) => Scaffold(
            appBar: AppBar(),
            body: ListView(
              padding: EdgeInsets.all(0),
              children: <Widget>[
                if (!widget.model.isPaid! && !widget.model.isInPaidPlaylist! ||
                    isInOwnedPlaylist ||
                    widget.model.isBought)
                  VimeoPlayer(
                      autoPlay: true,
                      id: VimeoHelpers.getVimeoIdFromLink(
                              widget.model.content?.url) ??
                          '')
                else if (widget.model.isPaid! && !widget.model.isBought)
                  BlockBaseWidget(
                    margin: EdgeInsets.only(top: Indents.md),
                    child: PayCard(
                      price: widget.model.price,
                      isBought: widget.model.isBought,
                      onBuy: () async {
                        var url =
                            await Api.Sale.getPaymentUrl(widget.model.id!);

                        if (url == null) {
                          SnackBarExtension.show(SnackBarExtension.error(
                              AppLocalizations.of(context)!
                                  .translate('payment.error')));
                        } else {
                          Navigator.of(context, rootNavigator: true)
                              .push(MaterialPageRoute(
                                  builder: (ctx) => PaymentScreen(
                                        title: AppLocalizations.of(context)!
                                            .translate(
                                                'payment.app_bar_content', [
                                          HelperMethods.capitalizeString(
                                              AppLocalizations.of(context)!
                                                  .translate('base.video'))
                                        ]),
                                        url: url,
                                        onPaymentDone: () async {
                                          await Api.User.refresh(true, true);
                                          var video = await Api.Entities
                                              .getById<Models.Video>(
                                                  widget.model.id);
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (ctx) =>
                                                      VideoViewScreen(
                                                          model: video as Models
                                                              .Video)));
                                          SnackBarExtension.show(
                                              SnackBarExtension.success(
                                                  AppLocalizations.of(context)!
                                                      .translate(
                                                          'payment.success_for',
                                                          [
                                                        AppLocalizations.of(
                                                                context)!
                                                            .translate(
                                                                'base.video')
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
                else if (widget.model.isInPaidPlaylist!)
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
                                loc!.translate('is_in_paid_playlist'),
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
                    BlockBaseWidget(
                        padding: EdgeInsets.only(
                            top: Indents.md,
                            left: Indents.md,
                            right: Indents.md),
                        header: widget.model.content?.name ?? 'Название видео',
                        child: CustomFutureBuilder<Models.Playlist?>(
                            future: Api.Entities.getById<Models.Playlist>(
                                widget.model.playlistId),
                            builder: (data) {
                              return CustomFutureBuilder<Models.Sport?>(
                                  future: Api.Entities.getById<Models.Sport>(
                                      data!.sportId),
                                  builder: (sportData) {
                                    return Row(
                                      children: <Widget>[
                                        InkWell(
                                          child:
                                              Text(sportData!.content!.name!),
                                          onTap: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  SportScreen(model: sportData),
                                            ));
                                          },
                                        ),
                                        Text(' - '),
                                        InkWell(
                                          child: Text(data.content!.name!),
                                          onTap: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  PlaylistScreen(model: data),
                                            ));
                                          },
                                        )
                                      ],
                                    );
                                  });
                            })),
                    if (widget.model.isBought && widget.model.isPaid!)
                      BlockBaseWidget(
                        child: PayCard(
                          isBought: widget.model.isBought,
                          price: widget.model.price,
                          alignment: MainAxisAlignment.start,
                        ),
                      ),
                    BlockBaseWidget(
                      child: Row(
                        children: [
                          ActionIcon(
                            signText: loc!.translate('like'),
                            //model?.likesAmount.toString() ?? '224''',
                            icon: Icons.thumb_up,
                            iconColor: widget.model.isLiked == true
                                ? Theme.of(context).colorScheme.secondary
                                : ExtremeColors.base[200]!,
                            onPressed: () async {
                              var userAction =
                                  await Api.User.toggleLike(widget.model.id);
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
                    BlockBaseWidget(
                      // TODO: to custom plugin
                      child: Linkify(
                        onOpen: (link) async {
                          if (await canLaunch(link.url)) {
                            await launch(link.url);
                          } else {
                            throw 'Could not launch $link';
                          }
                        },
                        text: widget.model.content?.description ?? '',
                        style: theme.textTheme.bodyText2,
                        linkStyle: theme.textTheme.bodyText2!
                            .merge(TextStyle(color: theme.colorScheme.primary, decoration: TextDecoration.underline)),
                      ),
                      // child: Text(
                      // widget.model.content?.description ??
                      //     '',
                      // style: Theme.of(context).textTheme.bodyText2),
                    ),
                    CustomFutureBuilder<Models.Playlist?>(
                        future: Api.Entities.getById<Models.Playlist>(
                            widget.model.playlistId),
                        builder: (data) {
                          if (data == null) return Container();
                          List<int> videosIds = data.videosIds!;
                          // Исключение этого же видео из выдачи
                          videosIds.remove(widget.model.id);
                          // Случайная перемешка видео для исключения выдачи одних и тех же видео
                          if (videosIds.length >= 3) {
                            videosIds.shuffle();
                            videosIds = videosIds.sublist(0, 3);
                          }

                          return videosIds.length == 0
                              ? Container()
                              : BlockBaseWidget(
                                  header: loc.translate("other_videos"),
                                  child:
                                      CustomFutureBuilder<List<Models.Video>?>(
                                          future: Api.Entities.getByIds<
                                              Models.Video>(videosIds),
                                          builder: (data) => CustomListBuilder(
                                              items: data,
                                              itemBuilder: (item) => VideoCard(
                                                    model: item as Models.Video,
                                                    aspectRatio: 16 / 9,
                                                  ))));
                        })
                  ],
                ),
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
