import 'package:extreme/models/main.dart';
import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:vimeoplayer/vimeoplayer.dart';
import '../widgets/video_card.dart';
import 'package:extreme/models/main.dart' as Models;

/// Создаёт экран просмотра видео

class VideoViewScreen extends StatelessWidget {
  final Models.Video model;
  VideoViewScreen({Key key, @required this.model}) : super(key: key);

  void _searchIconAction() {
    //TODO: Search some video function
  }
  @override
  Widget build(BuildContext context) {
    return ScreenBaseWidget(
      padding: EdgeInsets.only(bottom: ScreenBaseWidget.screenBottomIndent),
      appBar: AppBar(
        title: Text('Название видео'), // TODO: Title
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _searchIconAction,
          ),
        ],
      ),
      builder: (context) => <Widget>[
        VimeoPlayer(id: '395212534'),
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
                    signText: '224',
                    icon: Icons.thumb_up,
                    iconColor: ExtremeColors.primary,
                  ),
                  ActionIcon(
                      signText: 'В избранное',
                      icon: Icons.favorite,
                      iconColor: ExtremeColors.error),
                  ActionIcon(
                      signText: 'Поделиться',
                      icon: Icons.share,
                      iconColor: ExtremeColors.base[200]),
                ],
              ),
            ),
            BlockBaseWidget(
              child: Text(
                  model?.content?.description ??
                      'Начиная с версии 2.0 в ASP.NET Core была добавлена такая функциональность, как Razor Pages. Razor Pages предоставляют технологию, альтернативную системе Model-View-Controller. Razor Pages позволяют создавать страницы с кодом Razor, которые могут обрабатывать запросы...',
                  style: Theme.of(context).textTheme.bodyText2),
            ),
            BlockBaseWidget(
                header: 'Другие видео из плейлиста',
                child: Column(
                  children: [
                    VideoCard(
                      aspectRatio: 16 / 9,
                    ),
                    VideoCard(
                      aspectRatio: 16 / 9,
                    ),
                    VideoCard(
                      aspectRatio: 16 / 9,
                    ),
                  ],
                ))
          ],
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
            padding: EdgeInsets.zero, // like Icon padding
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
                EdgeInsets.only(top: Indents.sm), // Sign below like icon margin
            child: Text(
              signText, //'244',
              style: Theme.of(context).textTheme.caption.merge(TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                  )),
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
