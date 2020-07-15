import 'package:flutter/material.dart';

import '../kindOfSport.dart';

class SportCard extends StatelessWidget {
  // TODO: Добавить градиент как на playlist_card
  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.all(0),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Container(
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [Color(0x2709042c), Color(0x8309042c)],
                    center: Alignment.center,
                    radius: 2,
                    stops: <double>[0, 0.8],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: ExactAssetImage("extreme2.jpg"),
                  ),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: Center(
                          child: Text("Вид спорта",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.subtitle1),
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.playlist_play),
                                Text(
                                  "10",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .merge(TextStyle(
                                          fontWeight: FontWeight.w500)),
                                )
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "10",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .merge(TextStyle(
                                          fontWeight: FontWeight.w500)),
                                ),
                                Icon(Icons.local_movies),
                              ],
                            )
                          ],
                        ),
                      )
                    ]),
              ),
            ),
            Positioned.fill(
                child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KindOfSportScreen(),
                      ));
                },
              ),
            )),
          ],
        ));
  }
}