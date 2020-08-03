import 'package:carousel_pro/carousel_pro.dart';
import 'package:extreme/helpers/interfaces.dart';
import 'package:extreme/models/main.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/store/user/actions.dart';
import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/playlist_card.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:extreme/widgets/sport_card.dart';
import 'package:extreme/widgets/video_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:extreme/services/api/main.dart' as Api;

// Домашняя страница пользователя - Главная
var _authToken;

class HomeScreen extends StatelessWidget implements IWithNavigatorKey {
  final Key navigatorKey;

  HomeScreen({Key key, this.navigatorKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: неправильная тема из контекста
    var theme = Theme.of(context);
    TextEditingController _searchController = TextEditingController();
    _searchController.text = 'a';

    var store = StoreProvider.of<AppState>(context);
    print(store.state.user.email);

    dynamic playlist;
    return ScreenBaseWidget(
      padding: EdgeInsets.only(bottom: ScreenBaseWidget.screenBottomIndent),
      appBar: AppBar(
        title: Text('Extreme Insiders'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pushNamed('/search');
            },
          ),
        ],
      ),
      navigatorKey: navigatorKey,
      builder: (context) => <Widget>[
        SizedBox(
          height: 250.0,
          // child: Container(
          //   decoration: BoxDecoration(
          //       gradient: LinearGradient(stops: [
          //     0,
          //     0.8,
          //     1
          //   ], colors: [
          //     theme.colorScheme.background.withOpacity(0),
          //     theme.colorScheme.background.withOpacity(1),
          //     theme.colorScheme.background.withOpacity(1),
          //   ])),
          child: Stack(
            children: [
              Carousel(
                images: [
                  // TODO: fetch photos with rest api
                  NetworkImage(
                      'https://all4desktop.com/data_images/original/4234511-formula-1.jpg'),
                  ExactAssetImage("extreme2.jpg"),
                  ExactAssetImage("extreme2.jpg"),
                  ExactAssetImage("extreme2.jpg"),
                  // TODO: сделать компонент под дизайн
                ],
                dotSize: Indents.md / 2,
                dotSpacing: Indents.lg,
                dotColor: Theme.of(context).backgroundColor,
                indicatorBgPadding: 10.0,
                borderRadius: false,
                moveIndicatorFromBottom: 180.0,
                noRadiusForIndicator: true,
                overlayShadow: true,
                overlayShadowColors: Theme.of(context).colorScheme.background,
                overlayShadowSize: 1,
              ),
              // Container(
              //   decoration: BoxDecoration(
              //       gradient: LinearGradient(
              //         begin: Alignment.topCenter,
              //         end:  Alignment.bottomCenter,
              //         stops: [
              //     0,
              //     0.8,
              //     1
              //   ], colors: [
              //     theme.colorScheme.background.withOpacity(0),
              //     theme.colorScheme.background.withOpacity(1),
              //     theme.colorScheme.background.withOpacity(1),
              //   ])),
              // ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('GT3 Today',
                      style: Theme.of(context).textTheme.headline6),
                  Text('Race starts in 17:00 an Monza today',
                      style: Theme.of(context).textTheme.bodyText2.merge(
                          TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimary
                                  .withOpacity(0.7)))),
                  Container(
                    height: 25,
                  )
                ],
              )
            ],
          ),
        ),
        BlockBaseWidget.forScrollingViews(
            padding: EdgeInsets.only(top: Indents.md),
            header: 'Интересные виды спорта',
            child: Container(
              height: 50,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: Indents.md),
                scrollDirection: Axis.horizontal,
                children: [
                  SportCard(
                    aspectRatio: 3 / 1,
                    small: true,
                    padding: EdgeInsets.only(right: Indents.md),
                  ),
                  SportCard(
                    aspectRatio: 3 / 1,
                    small: true,
                    padding: EdgeInsets.only(right: Indents.md),
                  ),
                  SportCard(
                    aspectRatio: 3 / 1,
                    small: true,
                    padding: EdgeInsets.only(right: Indents.md),
                  ),
                  SportCard(
                    aspectRatio: 3 / 1,
                    small: true,
                    padding: EdgeInsets.only(right: Indents.md),
                  ),
                  SportCard(
                    aspectRatio: 3 / 1,
                    small: true,
                    padding: EdgeInsets.only(right: Indents.md),
                  ),
                ],
              ),
            )),
        BlockBaseWidget(
            margin: const EdgeInsets.only(bottom: Indents.smd),
            header: 'Рекомендуемые видео',
            child: Column(
              children: [
                VideoCard(
                  aspectRatio: 16 / 9,
                  margin: EdgeInsets.only(bottom: Indents.md),
                ),
                VideoCard(aspectRatio: 16 / 9),
              ],
            )),
        BlockBaseWidget.forScrollingViews(
            margin: EdgeInsets.zero,
            header: 'Последние обновления',
            child: Container(
              height: 100,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: Indents.md),
                scrollDirection: Axis.horizontal,
                children: [
                  PlayListCard(
                    aspectRatio: 16 / 9,
                    small: true,
                    padding: EdgeInsets.only(right: Indents.md),
                  ),
                  PlayListCard(
                    aspectRatio: 16 / 9,
                    small: true,
                    padding: EdgeInsets.only(right: Indents.md),
                  ),
                  PlayListCard(
                    aspectRatio: 16 / 9,
                    small: true,
                    padding: EdgeInsets.only(right: Indents.md),
                  ),
                  PlayListCard(
                    aspectRatio: 16 / 9,
                    small: true,
                    padding: EdgeInsets.only(right: Indents.md),
                  ),
                  PlayListCard(
                    aspectRatio: 16 / 9,
                    small: true,
                    padding: EdgeInsets.only(right: Indents.md),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
