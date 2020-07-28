//import 'dart:html';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:extreme/helpers/interfaces.dart';
import 'package:extreme/models/main.dart';
import 'package:extreme/store/main.dart';
//import 'package:extreme/services/api.dart' as Api;
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:extreme/widgets/video_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:extreme/services/api/main.dart' as Api;

// Домашняя страница пользователя - Главная
var _authToken;

class HomeScreen extends StatelessWidget
    implements IWithNavigatorKey {
  Key navigatorKey;

  HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: неправильная тема из контекста
    TextEditingController _searchController = TextEditingController();
    _searchController.text = 'a';

    var store = StoreProvider.of<AppState>(context);
    print(store.state.user.email);

    dynamic playlist;
    return ScreenBaseWidget(
      navigatorKey: navigatorKey,
      builder: (context) => <Widget>[
        SizedBox(
            height: 250.0,
            child: Carousel(
              images: [
                ExactAssetImage(
                    "extreme2.jpg"), // TODO: fetch photos with rest api
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
        RaisedButton(
          onPressed: () {
            Api.Authentication.login(email: "ar.luckjanov@yandex.ru", password: "123456");

          },
          child: Text("Auto login"),
        ),
        Auth(),
        //  RaisedButton(
        //   onPressed: _login('Hi'),
        //   child: Text('API tedt'),
        // )
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
        FutureBuilder<dynamic>(
          future: Api.Search(Api.EntityType.Playlist, 'a'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data.id.toString());
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
        FutureBuilder(
          future: Api.Recomended(1, 0),
          builder: (context, snapshot) {
            print('Snapshot has data: ' + snapshot.hasData.toString());
            if (snapshot.hasData) {
              print('Snapshot data 105: ' +snapshot.data.toString());
              return VideoCard(aspectRatio: 16/9,model: Video(content: Content(name: snapshot.data['content']['name'])),);//snapshot.data[0].toString())),);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
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
