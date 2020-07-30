import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/playlist_card.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../widgets/stats.dart';
import '../widgets/video_card.dart';

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
            child: Column(
              children: [
                VideoCard(
                  margin: EdgeInsets.only(bottom: Indents.xl),
                  aspectRatio: 16 / 9,
                ),
                VideoCard(
                  aspectRatio: 16 / 9,
                ),
                VideoCard(
                  aspectRatio: 16 / 9,
                ),
              ],
            )),

        // Список для скроллинга - Другие плейлисты
        //OtherPlaylistList(),
        BlockBaseWidget(
          header: 'Смотри также',
          child: Container(
            height: 100,
            child: ListView(
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
    final double screenWigth = MediaQuery.of(context).size.width;
    final double cardHeigth = 240;
    return Stack(
      children: <Widget>[
        Container(
            width: screenWigth,
            height: cardHeigth,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: ExactAssetImage("extreme2.jpg"),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0, 0.8, 1],
                      colors: [
                    theme.colorScheme.background.withOpacity(0),
                    theme.colorScheme.background.withOpacity(1),
                    theme.colorScheme.background.withOpacity(1),
                  ])
                  ),
            )),
        Positioned(
          bottom: 15,
          child: Container(
            color: Colors.transparent,
            width: screenWigth,
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: Indents.sm),
                  child: Text("Название плейлиста",
                      style: Theme.of(context).textTheme.headline6.merge(
                          TextStyle(
                              fontSize: 34,
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
      ],
    );
  }
}
