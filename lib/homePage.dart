import 'package:carousel_pro/carousel_pro.dart';
import 'package:extreme/kindOfSport.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/sport_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

// Домашняя страница пользователя - Главная

class HomeScreen extends StatelessWidget {
  void _searchIconAction() {
    // Search some video function
    print('object');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(14, 11, 38, 1),
      child: ListView(
        padding: const EdgeInsets.all(0.0),
        children: <Widget>[
          // Карусель + appBar
          new Stack(
            children: <Widget>[
              Container(
                color: Color.fromRGBO(14, 11, 38, 1),
                child: _carouselOfMainVideos(context),
              ),
              new Positioned(
                top: 0.0,
                left: 0.0,
                right: 0.0,
                child: AppBar(
                  title: Text('Extreme'),
                  actions: <Widget>[
                    new IconButton(
                      icon: new Icon(Icons.search),
                      onPressed: _searchIconAction,
                    ),
                  ],
                  backgroundColor: Colors.transparent, //No more green
                  elevation: 0.0, //Shadow gone
                ),
              ),
            ],
          ),

          // Список для горизонтального скроллинга - Интересные видео
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 5, 0),
            child: Text(
              'Интересные виды спорта',
              style: TextStyle(
                fontFamily: 'RobotoMono',
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),

          // Список интересных видео
          InterestingCardList(),

          // Список с рекомендуемыми видео
          Container(
            padding: EdgeInsets.fromLTRB(10, 5, 5, 0),
            child: Text(
              'Рекомендуемые видео',
              style: TextStyle(
                fontFamily: 'RobotoMono',
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),

          // Карточка для рекомендуемого видео
          VideoCard(),
          VideoCard(),
          VideoCard(),

          // Список для горизонтального скроллинга - Последние обновления
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
            child: Text(
              'Последние обновления',
              style: TextStyle(
                fontFamily: 'RobotoMono',
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),

          // Список последних обновлений
          LatestUpdatesCardList(),
          // TODO: check how redux work on Text(widget.store.state.likesCOunt.toString())
        ],
      ),
    );
  }
}

// Виджет с каруселью
Widget _carouselOfMainVideos(BuildContext context) {
  return SizedBox(
      height: 250.0,
      child: Carousel(
        images: [
//        NetworkImage('https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
//        NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
          ExactAssetImage("extreme2.jpg"), // TODO: fetch photos with rest api
          ExactAssetImage("extreme2.jpg"),
          ExactAssetImage("extreme2.jpg"),
          ExactAssetImage("extreme2.jpg"),
          ExactAssetImage("extreme2.jpg"),
        ],
        dotSize: 4.0,
        dotSpacing: 15.0,
        dotColor: Color.fromRGBO(255, 255, 255, 0.7),
        indicatorBgPadding: 10.0,
        dotBgColor: Colors.purple.withOpacity(0.0),
        borderRadius: false,
        moveIndicatorFromBottom: 180.0,
        noRadiusForIndicator: true,
        overlayShadow: true,
        overlayShadowColors: Color.fromRGBO(14, 11, 38, 1),
        overlayShadowSize: 0.7,
      ));
}

// Список для горизонтального скроллинга - Интересные видео
class InterestingCardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWigth = MediaQuery.of(context).size.width;
    final double cardHeigth = 110;
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.fromLTRB(0, 5, 5, 5),
      height: cardHeigth,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(right: Indents.md),
              child: AspectRatio(aspectRatio: 16 / 9, child: SportCard())),
          Container(
              margin: EdgeInsets.only(right: Indents.md),
              child: AspectRatio(aspectRatio: 16 / 9, child: SportCard())),
          Container(
              margin: EdgeInsets.only(right: Indents.md),
              child: AspectRatio(aspectRatio: 16 / 9, child: SportCard())),
          Container(
              margin: EdgeInsets.only(right: Indents.md),
              child: AspectRatio(aspectRatio: 16 / 9, child: SportCard())),
          Container(
              margin: EdgeInsets.only(right: Indents.md),
              child: AspectRatio(aspectRatio: 16 / 9, child: SportCard())),
        ],
      ),
    );
  }
}

// Карточка для интересных видео
// class SportCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final double screenWigth = MediaQuery.of(context).size.width;
//     final double cardHeigth = 110;
//     return Card(
//       elevation: 0.0,
//       color: Colors.transparent,
//       child: InkWell(
//         splashColor: Colors.blue.withAlpha(30),
//         onTap: () {
//           print('Card tapped.');
//           Navigator.push(context, MaterialPageRoute(
//             builder: (context) => KindOfSportScreen(),
//           ));
//         },
//         child: Container(
//           width: screenWigth / 2,
//           height: cardHeigth,
//           color: Colors.transparent,
//           child: Stack(
//             children: <Widget>[
//               Container(
//                 width: screenWigth / 2,
//                 height: cardHeigth,
//                 margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(5)),
//                   image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: ExactAssetImage("extreme2.jpg"),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 width: screenWigth / 2,
//                 height: cardHeigth,
//                 top: 0,
//                 left: 0,
//                 child: Container(
//                   alignment: Alignment.center,
//                   color: Color.fromRGBO(14, 11, 38, 0.4),
//                   child: Text(
//                     "Вид спорта",
//                     style: TextStyle(
//                       fontFamily: 'RobotoMono',
//                       fontSize: 18.0,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// Список для горизонтального скроллинга - Последние обновления
class LatestUpdatesCardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWigth = MediaQuery.of(context).size.width;
    final double cardHeigth = 110;
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.fromLTRB(0, 5, 5, 5),
      height: cardHeigth,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          LatestUpdateCard(),
          LatestUpdateCard(),
          LatestUpdateCard(),
          LatestUpdateCard(),
          LatestUpdateCard(),
        ],
      ),
    );
  }
}

// Карточка для последних обновлений
class LatestUpdateCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWigth = MediaQuery.of(context).size.width;
    final double cardHeigth = 110;
    return Card(
//      margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
      elevation: 0.0,
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          print('Card tapped.');
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => KindOfSportScreen(),
              ));
        },
        child: Container(
          width: screenWigth / 2,
          height: cardHeigth,
          color: Colors.transparent,
          child: Stack(
            children: <Widget>[
              Container(
                width: screenWigth / 2,
                height: cardHeigth,
                margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: ExactAssetImage("extreme2.jpg"),
                  ),
                ),
              ),
              Positioned(
                width: screenWigth / 2,
                height: cardHeigth,
                top: 0,
                left: 0,
                child: Container(
                  alignment: Alignment.center,
                  color: Color.fromRGBO(14, 11, 38, 0.4),
                  child: Text(
                    "Вид спорта",
                    style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              new Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.playlist_play,
                          color: Color.fromRGBO(182, 181, 189, 1),
                        ),
                        tooltip: 'Placeholder',
                        onPressed: () {},
                      ),
                      Text(
                        "10",
                        style: TextStyle(
                          fontFamily: 'RobotoMono',
                          fontSize: 15.0,
                          color: Color.fromRGBO(182, 181, 189, 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              new Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "89",
                        style: TextStyle(
                          fontFamily: 'RobotoMono',
                          fontSize: 15.0,
                          color: Color.fromRGBO(182, 181, 189, 1),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.local_movies,
                            color: Color.fromRGBO(182, 181, 189, 1)),
                        tooltip: 'Placeholder',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
