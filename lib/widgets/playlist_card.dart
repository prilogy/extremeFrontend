import 'package:extreme/styles/extreme_colors.dart';
import 'package:flutter/material.dart';

import '../playList.dart';
import 'stats.dart';

class PlayListCard extends StatelessWidget {
  // TODO: Добавить рипл эффект как на sport_card
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.fromLTRB(0, 12, 0, 8),
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          print('Card tapped.');
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlaylistScreen(),
              ));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: ExactAssetImage("extreme2.jpg"),
            ),
          ),
          child: Container(
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [
                          ExtremeColors.base.withOpacity(0.0),
                          ExtremeColors.base.withOpacity(0.75)
                        ],
                        center: Alignment.center,
                        radius: 1.5,
                        stops: <double>[0, 1],
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          IconButton(
                            // TODO: выделить в отдельный компонент и состояние когда кнопка активна(иконка залита красным цветом(объект в избранном))
                            alignment: Alignment.topRight,
                            padding: EdgeInsets.all(12),
                            icon: Icon(
                              Icons.favorite_border,
                              size: 30,
                              color: Color.fromRGBO(182, 181, 189, 1),
                            ),
                            tooltip: 'Placeholder',
                            onPressed: () {},
                          ),
                        ]),
                    Container(
                      padding: EdgeInsets.all(12),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(right: 12),
                                  child: Stats(
                                    icon: Icons.thumb_up,
                                    text: '1555',
                                    iconMarginRight: 5,
                                  ),
                                ),
                                Stats(
                                    icon: Icons.local_movies,
                                    text: '89',
                                    iconMarginRight: 5),
                              ],
                            ),
                            Text(
                              "Название плейлиста",
                              style: TextStyle(
                                letterSpacing: 0.8,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Roboto',
                                fontSize: 20.0,
                              ),
                            ),
                            Text(
                              "Достаточно Краткое описание плейлиста",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .merge(new TextStyle(color: Colors.white)),
                            ),
                          ]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
