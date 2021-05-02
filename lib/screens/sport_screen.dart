import 'package:extreme/helpers/helper_methods.dart';
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/helpers/app_localizations_helper.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/custom_future_builder.dart';
import 'package:extreme/widgets/custom_list_builder.dart';
import 'package:extreme/widgets/favorite_toggler.dart';
import 'package:extreme/widgets/movie_card.dart';
import 'package:extreme/widgets/playlist_card.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:extreme/widgets/stats.dart';
import 'package:extreme/widgets/video_card.dart';
import 'package:flutter/material.dart';
import 'package:extreme/services/api/main.dart' as Api;
import 'package:extreme/models/main.dart' as Models;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

/// Создаёт экран вида спорта
class SportScreen extends StatelessWidget {
  final Models.Sport model;

  const SportScreen({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)?.withBaseKey('sport_screen');
    var theme = Theme.of(context);

    return ScreenBaseWidget(
        padding: EdgeInsets.only(bottom: ScreenBaseWidget.screenBottomIndent),
        appBarComplex: (ctx, c) => ScrollAppBar(
              controller: c,
              actions: <Widget>[
                StoreConnector<AppState, Models.User>(
                  converter: (store) => store.state.user!,
                  builder: (ctx, state) => FavoriteToggler(
                    id: model.id,
                    status: model.isFavorite,
                    noAlign: true,
                    size: 24,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pushNamed(
                        '/search_in_entity',
                        arguments: [model.id, true]);
                  },
                ),
              ],
            ),
        builder: (context) => <Widget>[
              Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(model.content?.image?.path ?? ''),
                  )),
                  child: Container(
                    padding: EdgeInsets.all(Indents.md),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          model?.content?.name ??
                              loc!.translate('no_data.sport_name'),
                          style: theme.textTheme.headline5?.merge(TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.25)),
                        ),
                        Text(
                          model?.content?.description ?? '',
                          style: Theme.of(context).textTheme.bodyText2,
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: Indents.sm),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stats(
                                  icon: Icons.local_movies,
                                  text: model?.moviesIds?.length?.toString() ??
                                      '222'),
                              Stats(
                                  icon: Icons.playlist_play,
                                  text:
                                      model?.playlistsIds?.length?.toString() ??
                                          '233'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
              CustomFutureBuilder<List<Models.Movie>?>(
                future: Api.Entities.getByIds<Models.Movie>(model.moviesIds!),
                builder: (data) => (data?.length ?? 0) > 0
                    ? BlockBaseWidget.forScrollingViews(
                        header: HelperMethods.capitalizeString(
                            AppLocalizations.of(context)!.translate('base.movies')),
                        child: CustomListBuilder(
                            type: CustomListBuilderTypes.horizontalList,
                            connectToStore: true,
                            items: data,
                            height: 200,
                            itemBuilder: (item) => MovieCard(
                                  model: item as Models.Movie,
                                  aspectRatio: 9 / 16,
                                )))
                    : Container(),
              ),
              BlockBaseWidget(
                  header: AppLocalizations.of(context)!
                      .translate('helper.users_choice'),
                  child: CustomFutureBuilder<Models.Playlist?>(
                      future: Api.Entities.getById<Models.Playlist>(
                          model.bestPlaylistId),
                      builder: (data) => PlayListCard(
                            model: data,
                            aspectRatio: 16 / 9,
                          ))),
              BlockBaseWidget(
                  header: loc!.translate('recommended',
                      [AppLocalizations.of(context)!.translate('base.video')]),
                  child: CustomFutureBuilder<Models.Video?>(
                      future: Api.Entities.getById<Models.Video>(model.bestVideoId),
                      builder: (data) {
                        return data != null ? VideoCard(
                          model: data,
                        ) : Container();
                      })),
              BlockBaseWidget(
                  margin: EdgeInsets.all(0),
                  header: HelperMethods.capitalizeString(
                      AppLocalizations.of(context)!.translate('base.playlists')),
                  child: CustomFutureBuilder<List<Models.Playlist>?>(
                    future: Api.Entities.getByIds<Models.Playlist>(
                        model.playlistsIds!),
                    builder: (data) => CustomListBuilder(
                        type: CustomListBuilderTypes.verticalList,
                        connectToStore: true,
                        items: data,
                        itemBuilder: (item) => PlayListCard(
                              aspectRatio: 16 / 9,
                              model: item as Models.Playlist,
                            )),
                  )),
            ]);
  }
}
