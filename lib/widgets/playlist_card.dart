// Карточка с популярным плейлистом
import 'package:flutter/material.dart';

import '../playList.dart';
import 'stats.dart';

class PlayListCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    TextTheme partialTheme = TextTheme(caption: TextStyle(color: Colors.white));
    theme = theme.copyWith(textTheme: theme.textTheme.merge(partialTheme));
    double screenWigth = MediaQuery.of(context).size.width;
    final double cardHeigth = 200;
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
          child: Stack(
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: [Color(0x5009042c), Color(0xA209042c)],
                          center: Alignment.center,
                          radius: 1,
                          stops: <double>[0, 1],
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
                                      .merge(
                                          new TextStyle(color: Colors.white)),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

