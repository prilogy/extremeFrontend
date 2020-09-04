import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/helpers/app_localizations_helper.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/custom_future_builder.dart';
import 'package:extreme/widgets/custom_list_builder.dart';
import 'package:extreme/widgets/movie_card.dart';
import 'package:extreme/widgets/playlist_card.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:extreme/widgets/stats.dart';
import 'package:extreme/widgets/video_card.dart';
import 'package:flutter/material.dart';
import 'package:extreme/services/api/main.dart' as Api;
import 'package:extreme/models/main.dart' as Models;

/// Создаёт экран вида спорта
class SportScreen extends StatelessWidget {
  final Models.Sport model;
  const SportScreen({Key key,@required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context).withBaseKey('sport_screen');

    var theme = Theme.of(context);
    return ScreenBaseWidget(
      padding: EdgeInsets.only(bottom: ScreenBaseWidget.screenBottomIndent),
      appBar: AppBar(
        title: Text(model?.content?.name ?? "Unnamed sport"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.of(context, rootNavigator: true)
                  .pushNamed('/search'); // TODO: sport search ?
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
              image: NetworkImage(model.content.image.path),
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
                    model?.content?.name ?? loc.translate('no_data.sport_name'),
                    style: theme.textTheme.headline5.merge(TextStyle(
                        fontWeight: FontWeight.bold, letterSpacing: 0.25)),
                  ),
                  Text(model?.content?.description ?? '',
                      style: Theme.of(context).textTheme.bodyText2, textAlign: TextAlign.center,),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: Indents.sm),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stats(icon: Icons.thumb_up, text: '1343'),
                        Stats(
                            icon: Icons.local_movies,
                            text:
                                model?.moviesIds?.length?.toString() ?? '222'),
                        Stats(
                            icon: Icons.playlist_play,
                            text: model?.playlistsIds?.length?.toString() ??
                                '233'),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(
                          onPressed: () {},
                          color: theme.colorScheme.onSurface,
                          child: Text(loc.translate("button.videos"),
                              style: theme.textTheme.button.merge(TextStyle(
                                  color: theme.colorScheme.surface)))),
                      RaisedButton(
                          onPressed: () {},
                          color: theme.colorScheme.onSurface,
                          child: Text(loc.translate("button.playlists"),
                              style: theme.textTheme.button.merge(TextStyle(
                                  color: theme.colorScheme.surface)))),
                      RaisedButton(
                          onPressed: () {},
                          color: theme.colorScheme.onSurface,
                          child: Text(loc.translate("button.movies"),
                              style: theme.textTheme.button.merge(TextStyle(
                                  color: theme.colorScheme.surface)))),
                    ],
                  )
                ],
              ),
            )),
        BlockBaseWidget(
            header: loc.translate("recommended"),
            child: CustomFutureBuilder<List<Models.Movie>>(
              future: Api.Entities.recommended<Models.Movie>(1, 5),
              builder: (data) => CustomListBuilder(
                  type: CustomListBuilderTypes.horizontalList,
                  connectToStore: true,
                  items: data,
                  height: 150,
                  itemBuilder: (item) => MovieCard(
                        model: item,
                        aspectRatio: 9 / 16,
                      )),
            )),
        // TODO: реализовать вывод лучшего плейлиста и лучшего вывода
        // BlockBaseWidget(
        //   header: 'Лучший плейлист',
        //   child: PlayListCard(
        //     aspectRatio: 16 / 9,
        //   ),
        // ),
        // BlockBaseWidget(
        //   header: 'Лучшее видео',
        //   child: VideoCard(
        //     aspectRatio: 16 / 9,
        //   ),
        // )
      ],
    );
  }
}
