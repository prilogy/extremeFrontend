import 'package:carousel_pro/carousel_pro.dart';
import 'package:extreme/helpers/interfaces.dart';
import 'package:extreme/kindOfSport.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:extreme/widgets/sport_card.dart';
import 'package:extreme/widgets/video_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

// Домашняя страница пользователя - Главная

class HomeScreen extends StatelessWidget
    implements IWithAppBar, IWithNavigatorKey {
  Key navigatorKey;

  HomeScreen({Key key}) : super(key: key);

  final Widget appBar = null;

  @override
  Widget build(BuildContext context) {
    // TODO: неправильная тема из контекста
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (settings) => MaterialPageRoute(
        builder: (context) => ScreenBaseWidget(
          appBar: appBar,
          children: <Widget>[
            SizedBox(
                height: 250.0,
                child: Carousel(
                  images: [
                    ExactAssetImage("extreme2.jpg"),
                    // TODO: fetch photos with rest api
                    ExactAssetImage("extreme2.jpg"),
                    ExactAssetImage("extreme2.jpg"),
                    ExactAssetImage("extreme2.jpg"),
                    Container(
                      child: Text("sadas"),
                    )
                    // TODO: сделать компонент под дизайн
                  ],
                  dotSize: Indents.sm / 2,
                  dotSpacing: Indents.md,
                  dotColor: Theme.of(context).backgroundColor,
                  indicatorBgPadding: 10.0,
                  borderRadius: false,
                  moveIndicatorFromBottom: 180.0,
                  noRadiusForIndicator: true,
                  overlayShadow: true,
                  overlayShadowColors: Theme.of(context).colorScheme.background,
                  overlayShadowSize: 0.7,
                )),
            VideoCard(aspectRatio: 16 / 9),
          ],
        ),
      ),
    );
  }
}

//class HomeScreen extends StatelessWidget {
//  void _searchIconAction() {
//    // Search some video function
//    print('object');
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return ScreenBaseWidget(
//        padding: EdgeInsets.only(bottom: ScreenBaseWidget.screenBottomIndent, top: 0),
//        children: <Widget>[
//          // Карусель + appBar
//          new Stack(
//            children: <Widget>[
//              Container(
//                color: Color.fromRGBO(14, 11, 38, 1),
//                child: _carouselOfMainVideos(context),
//              ),
//              new Positioned(
//                top: 0.0,
//                left: 0.0,
//                right: 0.0,
//                child: AppBar(
//                  title: Text('Extreme'),
//                  actions: <Widget>[
//                    new IconButton(
//                      icon: new Icon(Icons.search),
//                      onPressed: _searchIconAction,
//                    ),
//                  ],
//                  backgroundColor: Colors.transparent, //No more green
//                  elevation: 0.0, //Shadow gone
//                ),
//              ),
//            ],
//          ),
//
//          BlockBaseWidget.forScrollingViews(
//            header: "Интересные виды спорта",
//            child: InterestingCardList(),
//          ),
//
//          // Список с рекомендуемыми видео
//          Container(
//            padding: EdgeInsets.fromLTRB(10, 5, 5, 0),
//            child: Text(
//              'Рекомендуемые видео',
//              style: TextStyle(
//                fontFamily: 'RobotoMono',
//                fontSize: 20.0,
//                color: Colors.white,
//              ),
//            ),
//          ),
//
//          // Карточка для рекомендуемого видео
//          VideoCard(),
//          VideoCard(),
//          VideoCard(),
//
//          // Список для горизонтального скроллинга - Последние обновления
//          Container(
//            padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
//            child: Text(
//              'Последние обновления',
//              style: TextStyle(
//                fontFamily: 'RobotoMono',
//                fontSize: 20.0,
//                color: Colors.white,
//              ),
//            ),
//          ),
//
//          // Список последних обновлений
//          LatestUpdatesCardList(),
//          // TODO: check how redux work on Text(widget.store.state.likesCOunt.toString())
//        ],
//    );
//  }
//}
//
//
//// Список для горизонтального скроллинга - Интересные видео
//class InterestingCardList extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    final double screenWigth = MediaQuery.of(context).size.width;
//    final double cardHeigth = 110;
//    return Container(
//      color: Colors.transparent,
//      height: cardHeigth,
//      child: ListView(
//        padding: EdgeInsets.only(left: Indents.md),
//        scrollDirection: Axis.horizontal,
//        children: <Widget>[
//          Container(
//              margin: EdgeInsets.only(right: Indents.md),
//              child: AspectRatio(aspectRatio: 16 / 9, child: SportCard())),
//          Container(
//              margin: EdgeInsets.only(right: Indents.md),
//              child: AspectRatio(aspectRatio: 16 / 9, child: SportCard())),
//          Container(
//              margin: EdgeInsets.only(right: Indents.md),
//              child: AspectRatio(aspectRatio: 16 / 9, child: SportCard())),
//          Container(
//              margin: EdgeInsets.only(right: Indents.md),
//              child: AspectRatio(aspectRatio: 16 / 9, child: SportCard())),
//          Container(
//              margin: EdgeInsets.only(right: Indents.md),
//              child: AspectRatio(aspectRatio: 16 / 9, child: SportCard())),
//        ],
//      ),
//    );
//  }
//}
