import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'kind_of_sport.dart';
import '../widgets/stats.dart';
import '../widgets/video_card.dart';

// Экран просмотра плейлиста

class PlaylistScreen extends StatelessWidget {
//  final String text;

  // receive data from the FirstScreen as a parameter
  PlaylistScreen({
    Key key,
//    @required this.text
  }) : super(key: key);

  void _searchIconAction() {
    // Search some video function
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(47, 44, 71, 1),
        title: Text('Название плейлиста'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _searchIconAction,
          ),
        ],
      ),
      body: Container(
        color: Color.fromRGBO(14, 11, 38, 1),
        child: ListView(
            padding: const EdgeInsets.all(0.0),
            children: <Widget>[

              // Карточка плейлиста в самом верху страницы
              HeaderPlaylist(),

              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 5, 5),
                child: Text(
                  'Видео',
                  style: TextStyle(
                    fontFamily: 'RobotoMono',
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),

              // Карточка с видео и для просмотра видео
              VideoCard(aspectRatio: 16/9,),
              // Карточка с видео и для просмотра видео
              VideoCard(aspectRatio: 16/9,),
              // Карточка с видео и для просмотра видео
              VideoCard(aspectRatio: 16/9,),

              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                child: Text(
                  'Смотри также',
                  style: TextStyle(
                    fontFamily: 'RobotoMono',
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),

              // Список для скроллинга - Другие плейлисты
              OtherPlaylistList(),
            ],
        ),
      ),
    );
  }
}

// Карточка плейлиста в самом верху страницы
class HeaderPlaylist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWigth = MediaQuery.of(context).size.width;
    final double cardHeigth = 240;
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          width: screenWigth,
          height: cardHeigth,
          decoration: BoxDecoration(
//                        borderRadius: BorderRadius.all(Radius.circular(10)),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: ExactAssetImage("extreme2.jpg"),
            ),
          ),
        ),
        Positioned(
            width: screenWigth,
            height: cardHeigth,
            top: 0,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    const Color.fromRGBO(14, 11, 38, 1),
                    const Color.fromRGBO(14, 11, 38, 0)
                  ],
                  tileMode:
                      TileMode.repeated, // repeats the gradient over the canvas
                ),
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
                  margin: EdgeInsets.only(bottom: 5),
                  child: Text(
                    "Название плейлиста",
                     style: Theme.of(context).textTheme.headline6
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Text(
                    "Описание данного плейлиста",
                    style: Theme.of(context).textTheme.bodyText2
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stats(icon: Icons.thumb_up, text: 105.toString(), marginBetween: 5,),
                    Stats(icon: Icons.local_movies, text: 354.toString(),),
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