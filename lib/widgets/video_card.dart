import 'package:flutter/material.dart';

import '../videoViewPage.dart';

class VideoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWigth = MediaQuery.of(context).size.width;
    final double cardHeigth = 200;
    return Card(
      elevation: 0.0,
      margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
      color: Colors.transparent,
      
        child: Container(
          width: screenWigth / 2,
          color: Colors.transparent,
          child: Column(
            children: <Widget>[InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VideoViewScreen(),
              ));
          print('Card tapped.');
        },
              child: Stack(
                children: <Widget>[
                  Container(
                    width: screenWigth,
                    height: cardHeigth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: ExactAssetImage("extreme2.jpg"),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      color: Colors.transparent,
                      child: IconButton(
                        icon: Icon(
                          Icons.favorite_border,
                          color: Color.fromRGBO(182, 181, 189, 1),
                        ),
                        tooltip: 'Placeholder',
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 15,
                    right: 10,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      alignment: Alignment.center,
                      color: Colors.black54,
                      child: Text(
                        "7:34",
                        style: TextStyle(
                          fontFamily: 'RobotoMono',
                          fontSize: 12.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),),
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                color: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Blancpain GT3 - 3 hours Monza Race / Replay',
                                style: TextStyle(
                                  fontFamily: 'RobotoMono',
                                  fontSize: 14.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                '5 дней назад',
                                style: TextStyle(
                                  fontFamily: 'RobotoMono',
                                  fontSize: 12.0,
                                  color: Color.fromRGBO(182, 181, 189, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          alignment: Alignment.centerRight,
                          icon: Icon(
                            Icons.more_vert,
                            size: 20,
                            color: Color.fromRGBO(182, 181, 189, 1),
                          ),
                          tooltip: 'Placeholder',
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}
