//import 'dart:html';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:extreme/helpers/interfaces.dart';
import 'package:extreme/models/main.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/store/user/actions.dart';
//import 'package:extreme/services/api.dart' as Api;
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
  void _searchIconAction() {}

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
            onPressed: _searchIconAction,
          ),
        ],
      ),
      navigatorKey: navigatorKey,
      builder: (context) => <Widget>[
        SizedBox(
          height: 250.0,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                stops: [0, 0.8, 1],
                colors: [
                  theme.colorScheme.background.withOpacity(0),
                  theme.colorScheme.background.withOpacity(1),
                  theme.colorScheme.background.withOpacity(1),
                ]
              )
            ),
            child: Carousel(
                images: [
                  ExactAssetImage(
                      "extreme2.jpg"), // TODO: fetch photos with rest api
                  ExactAssetImage("extreme2.jpg"),
                  ExactAssetImage("extreme2.jpg"),
                  ExactAssetImage("extreme2.jpg"),
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
              ),
          ),
        ),
        BlockBaseWidget.forScrollingViews(
            header: 'Интересные виды спорта',
            child: Container(
              height: 50,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: Indents.md),
                scrollDirection: Axis.horizontal,
                children: [
                  SportCard(aspectRatio: 16 / 7,small: true,padding: EdgeInsets.only(right: Indents.md),),
                  SportCard(aspectRatio: 16 / 7,small: true,padding: EdgeInsets.only(right: Indents.md),),
                  SportCard(aspectRatio: 16 / 7,small: true,padding: EdgeInsets.only(right: Indents.md),),
                  SportCard(aspectRatio: 16 / 7,small: true,padding: EdgeInsets.only(right: Indents.md),),
                  SportCard(aspectRatio: 16 / 7,small: true,padding: EdgeInsets.only(right: Indents.md),),
                  
                ],
              ),
            )),
        BlockBaseWidget(
            header: 'Рекомендуемые видео',
            child: Column(
              children: [
                VideoCard(aspectRatio: 16 / 9),
                VideoCard(aspectRatio: 16 / 9),
              ],
            )),
        BlockBaseWidget.forScrollingViews(
            header: 'Последние обновления',
            child: Container(
              height: 100,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: Indents.md),
                scrollDirection: Axis.horizontal,
                children: [
                  SportCard(
                    aspectRatio: 16 / 9,
                    small: true,
                  ),
                  PlayListCard(
                    aspectRatio: 16 / 9,
                    small: true,
                  ),
                  SportCard(
                    aspectRatio: 16 / 9,
                    small: true,
                  ),
                  PlayListCard(
                    aspectRatio: 16 / 9,
                    small: true,
                  ),
                  SportCard(
                    aspectRatio: 16 / 9,
                    small: true,
                  ),
                ],
              ),
            )),
        Text(store.state.user.email),
        RaisedButton(
          onPressed: () {
            store.dispatch(SetUser(null));
            Navigator.of(context, rootNavigator: true).pushNamed('/auth');
          },
          child: Text('log out'),
        ),
        RaisedButton(
          onPressed: () {
            Api.Authentication.login(
                email: "ar.luckjanov@yandex.ru", password: "123456");
          },
          child: Text("Auto login"),
        ),
        Auth(),
        Text('Найти плейлист: '),
        TextField(
          controller: _searchController,
        ),
        RaisedButton(
          onPressed: () {
            print('Response is ready: ' +
                Api.Search(Api.EntityType.Playlist, _searchController.text)
                    .toString());
          },
          child: Text('Поиск'),
        ),
        FutureBuilder(
          future: Api.Recomend(1, 0),
          builder: (context, snapshot) {
            print('Snapshot has data: ' + snapshot.hasData.toString());
            if (snapshot.hasData) {
              print('Snapshot data 105: ' + snapshot.data.toString());
              return VideoCard(
                aspectRatio: 16 / 9,
                model: Video(
                    content: Content(name: snapshot.data['content']['name'])),
              ); //snapshot.data[0].toString())),);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
        Column(
          children: [],
        )
      ],
    );
  }
}

class User {
  final int id;
  final String email;
  final String jwt;

  User({this.id, this.email, this.jwt});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'], email: json['email'], jwt: json['token']);
  }
}

class Auth extends StatelessWidget {
  const Auth({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passController = TextEditingController();
    return Column(
      children: <Widget>[
        TextFormField(
          controller: _emailController,
          //
        ),
        TextFormField(
          controller: _passController,
          //onFieldSubmitted: _search,
        ),
        RaisedButton(
          child: (Text('Submit')),
          onPressed: () {
            // Api.Login(_emailController.text, _passController.text);
          },
        )
      ],
    );
  }
}
