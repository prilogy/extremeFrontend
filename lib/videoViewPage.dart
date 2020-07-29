import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:vimeoplayer/vimeoplayer.dart';
import 'screens/kind_of_sport.dart';
import 'widgets/video_card.dart';

/// Создаёт экран просмотра видео

class VideoViewScreen extends StatelessWidget {
//  final String text;

  // receive data from the FirstScreen as a parameter
  VideoViewScreen({
    Key key,
//    @required this.text
  }) : super(key: key);

  void _searchIconAction() {
    //TODO: Search some video function
  }

  @override
  Widget build(BuildContext context) {
    final double screenWigth = MediaQuery.of(context).size.width;
//    final double cardHeigth = 240;
    return ScreenBaseWidget(
      // appBar: AppBar(
      //   title: Text('Название видео'), // TODO: Title
      //   backgroundColor: Color.fromRGBO(47, 44, 71, 1),
      //   actions: <Widget>[
      //     new IconButton(
      //       icon: new Icon(Icons.search),
      //       onPressed: _searchIconAction,
      //     ),
      //   ],
      // ),
      builder: (context) => <Widget>[
        Container(
          color: Color.fromRGBO(14, 11, 38, 1),
          child: ListView(
            padding: const EdgeInsets.all(0.0),
            children: <Widget>[
              // -----------------------------
              // Видео
              VimeoPlayer(id: '395212534'),
              // -----------------------------

              // Название видео + название спорта и плейлиста
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Название видео',
                        style: TextStyle(
                          fontFamily: 'RobotoMono',
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Text(
                        'Название спорта - плейлист',
                        style: TextStyle(
                          fontFamily: 'RobotoMono',
                          fontSize: 14.0,
                          color: Color.fromRGBO(182, 181, 189, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Кнопки располагающиеся под видео

              Container(
                margin: EdgeInsets.fromLTRB(
                    10, 10, 10, 10), // entire container with icons margin
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ActionIcon(
                      icon: Icons.thumb_up,
                      iconColor: Color.fromRGBO(34, 163, 210, 1),
                      signText: '244',
                      onPressed: () => {print('Like button tapped')},
                    ),
                    ActionIcon(
                      icon: Icons.favorite,
                      iconColor: Color.fromRGBO(235, 87, 87, 1),
                      signText: 'В избранное',
                      onPressed: () => {print('Fav icon tapped')},
                    ),
                    ActionIcon(
                      icon: Icons.share,
                      iconColor: Color.fromRGBO(182, 181, 189, 1),
                      signText: 'Поделиться',
                      onPressed: () => {print('Share icon tapped')},
                    ),
                  ],
                ),
              ),
              // Описание к видео
              VideoDescription(
                  text:
                      'Начиная с версии 2.0 в ASP.NET Core была добавлена такая функциональность, как Razor Pages. Razor Pages предоставляют технологию, альтернативную системе Model-View-Controller. Razor Pages позволяют создавать страницы с кодом Razor, которые могут обрабатывать запросы...'),

              Container(
                padding: EdgeInsets.fromLTRB(10, 15, 5, 5),
                child: Text(
                  'Другие видео из плейлиста',
                  style: TextStyle(
                    fontFamily: 'RobotoMono',
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),

              // Карточка с видео и для просмотра видео из этого же плейлиста
              VideoCard(),
              // Карточка с видео и для просмотра видео из этого же плейлиста
              VideoCard(),
              // Карточка с видео и для просмотра видео из этого же плейлиста
              VideoCard(),
            ],
          ),
        ),
      ],
    );
  }
}
/// Создаёт иконку с действием
class ActionIcon extends StatelessWidget {
  // TODO: convert to stateful Widget

  final IconData icon;
//EdgeInsets margin; // margin container
  final Color iconColor; // цвет icon
  final Function onPressed; // функция-обработчик нажатия на icon
  final String signText;

  ActionIcon({this.icon, this.iconColor, this.onPressed, this.signText});
  @override
  Widget build(BuildContext context) {
    return Container(
      // Like
      margin: EdgeInsets.fromLTRB(0, 0, 15, 0), // like container margin
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0), // like Icon padding
            alignment: Alignment.centerRight,
            icon: Icon(icon, //Icons.thumb_up,
                size: 45,
                color: iconColor //Color.fromRGBO(34, 163, 210, 1),
                ),
            tooltip: 'Placeholder',
            onPressed: onPressed,
          ),

          Container(
            margin:
                EdgeInsets.fromLTRB(0, 5, 0, 0), // Sign below like icon margin
            child: Text(
              signText, //'244',
              style: TextStyle(
                fontFamily: 'RobotoMono',
                fontSize: 14.0,
                color: Color.fromRGBO(182, 181, 189, 1),
              ),
            ),
          ),

//                      Icons.favorite_border,
        ],
      ),
    );
  }
}

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
              text, //'Начиная с версии 2.0 в ASP.NET Core была добавлена такая функциональность, как Razor Pages. Razor Pages предоставляют технологию, альтернативную системе Model-View-Controller. Razor Pages позволяют создавать страницы с кодом Razor, которые могут обрабатывать запросы...',
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
