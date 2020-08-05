import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/custom_list_builder.dart';
import 'package:extreme/widgets/playlist_card.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../widgets/stats.dart';
import '../widgets/video_card.dart';
import 'package:extreme/services/api/main.dart' as Api;
import 'package:extreme/models/main.dart' as Models;

/// Создаёт экран просмотра плейлиста

class PlaylistScreen extends StatelessWidget {
//  final String text;

  // receive data from the FirstScreen as a parameter
  PlaylistScreen({
    Key key,
//    @required this.text
  }) : super(key: key);

  void _searchIconAction() {
    // TODO: Search video function
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBaseWidget(
      padding: EdgeInsets.only(bottom: ScreenBaseWidget.screenBottomIndent),
      appBar: AppBar(
        title: Text('Название плейлиста'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _searchIconAction,
          ),
        ],
      ),
      builder: (context) => <Widget>[
        // Карточка плейлиста в самом верху страницы
        HeaderPlaylist(),

        BlockBaseWidget(
          header: 'Видео',
          child: FutureBuilder(
            // TODO: change to current playlist id
            future: Api.Entities.playlistVideos(3),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return CustomListBuilder(
                    items: snapshot.data,
                    itemBuilder: (item) =>
                        VideoCard(aspectRatio: 16 / 9, model: item));
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else
                return Center(
                  child: CircularProgressIndicator(),
                );
            },
          ),
        ),

        // Список для скроллинга - Другие плейлисты
        //OtherPlaylistList(),
        BlockBaseWidget.forScrollingViews(
          header: 'Смотри также',
          child: Container(
            height: 100,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: Indents.sm),
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  child: PlayListCard(
                    small: true,
                    aspectRatio: 16 / 9,
                  ),
                ),
                PlayListCard(
                  small: true,
                  aspectRatio: 16 / 9,
                ),
                PlayListCard(
                  small: true,
                  aspectRatio: 16 / 9,
                ),
                PlayListCard(
                  small: true,
                  aspectRatio: 16 / 9,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

// Карточка плейлиста в самом верху страницы
class HeaderPlaylist extends StatelessWidget {
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
                image: ExactAssetImage("assets/images/extreme2.jpg"),
              ),
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
                        "Название плейлиста лалал лалала лала алала лалал ал аа лал ",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5.merge(
                            TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.25))),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: Indents.sm),
                    child: Text("Описание данного плейлиста",
                        style: Theme.of(context).textTheme.bodyText2),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Stats(
                        icon: Icons.thumb_up,
                        text: 105.toString(),
                        marginBetween: 5,
                      ),
                      Stats(
                        icon: Icons.local_movies,
                        text: 354.toString(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
