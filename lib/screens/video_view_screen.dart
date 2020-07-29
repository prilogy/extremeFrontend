import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:vimeoplayer/vimeoplayer.dart';
import 'kind_of_sport.dart';
import '../widgets/video_card.dart';

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
// // -----------------------------
//               // Видео
//               VimeoPlayer(id: '395212534'),
//               // -
  @override
  Widget build(BuildContext context) {
    final double screenWigth = MediaQuery.of(context).size.width;
//    final double cardHeigth = 240;
    return ScreenBaseWidget(
      appBar: AppBar(
        title: Text('Название видео'), // TODO: Title
        actions: <Widget>[
          IconButton(
            icon:  Icon(Icons.search),
            onPressed: _searchIconAction,
          ),
        ],
      ),
      builder: (context) => <Widget>[
        
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
