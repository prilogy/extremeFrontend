import 'package:extreme/helpers/app_localizations_helper.dart';
import 'package:extreme/helpers/interfaces.dart';
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/screens/movies_screen.dart';
import 'package:extreme/screens/playlists_screen.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/custom_future_builder.dart';
import 'package:extreme/widgets/custom_list_builder.dart';
import 'package:extreme/widgets/playlist_card.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:extreme/widgets/sport_card.dart';
import 'package:flutter/material.dart';
import 'package:extreme/services/api/main.dart' as Api;
import 'package:extreme/models/main.dart' as Models;
import 'package:flutter_redux/flutter_redux.dart';

/// Вторая страница - Просмотр (Browse в bottomNavigationBar)

class BrowseScreen extends StatefulWidget {
  final Key navigatorKey;

  BrowseScreen({this.navigatorKey});

  @override
  _BrowseScreenState createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  final Widget appBar = AppBar(
    title: Text("Просмотр"),
    actions: <Widget>[
      new IconButton(
        icon: new Icon(Icons.search),
        onPressed: () {
          print("smth");
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    var loc = AppLocalizations.of(context).withBaseKey('browse_screen');

    return ScreenBaseWidget(
        appBar: appBar,
        navigatorKey: widget.navigatorKey,
        builder: (context) => [
              Container(
                margin: EdgeInsets.only(bottom: Indents.lg),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CategoryButton(
                        text: loc.translate('playlists'),
                        icon: Icons.playlist_play,
                        pushTo: Playlists()),
                    CategoryButton(
                        text: loc.translate('movies'),
                        icon: Icons.movie,
                        pushTo: MoviesList())
                  ],
                ),
              ),
              BlockBaseWidget(
                  child: CustomFutureBuilder<List<Models.Sport>>(
                future: Api.Entities.getAll<Models.Sport>(),
                builder: (data) => CustomListBuilder<Models.Sport>(
                    type: CustomListBuilderTypes.grid,
                    items: data,
                    itemBuilder: (item) => SportCard(
                          model: item,
                          aspectRatio: 16 / 9,
                        )),
              )),
              BlockBaseWidget(
                header: loc.translate('popular_playlists'),
                margin: EdgeInsets.zero,
                child: CustomFutureBuilder<List<Models.Playlist>>(
                  future: Api.Entities.getAll<Models.Playlist>(1, 2),
                  builder: (data) => CustomListBuilder<Models.Playlist>(
                    connectToStore: true,
                    type: CustomListBuilderTypes.verticalList,
                    items: data,
                    itemBuilder: (item) => PlayListCard(
                      model: item,
                      aspectRatio: 16 / 9,
                    ),
                  ),
                ),
              ),
            ]);
  }
}

class CategoryButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Widget pushTo;

  CategoryButton({this.text, this.icon, this.pushTo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Indents.md),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            iconSize: 50,
            icon: Icon(icon, color: Colors.white),
            tooltip: text,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => pushTo,
              ));
            },
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
