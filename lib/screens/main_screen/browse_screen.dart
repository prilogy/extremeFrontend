import 'package:extreme/helpers/app_localizations_helper.dart';
import 'package:extreme/helpers/interfaces.dart';
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/screens/movies_screen.dart';
import 'package:extreme/screens/playlists_screen.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/custom_list_builder.dart';
import 'package:extreme/widgets/playlist_card.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:extreme/widgets/sport_card.dart';
import 'package:flutter/material.dart';
import 'package:extreme/services/api/main.dart' as Api;
import 'package:extreme/models/main.dart' as Models;

/// Вторая страница - Просмотр (Browse в bottomNavigationBar)

class BrowseScreen extends StatelessWidget implements IWithNavigatorKey {
  final Key navigatorKey;

  BrowseScreen({Key key, this.navigatorKey}) : super(key: key);

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
        navigatorKey: navigatorKey,
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
                        text: loc.translate('movies'), icon: Icons.movie, pushTo: MoviesList())
                  ],
                ),
              ),
              BlockBaseWidget(
                child: FutureBuilder(
                    future: Api.Entities.getAll<Models.Sport>(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return CustomListBuilder<Models.Sport>(
                            type: CustomListBuilderTypes.grid,
                            items: snapshot.data,
                            itemBuilder: (item) => SportCard(
                                  model: item,
                                  aspectRatio: 16 / 9,
                                ));
                      } else if (snapshot.hasError)
                        return Text(snapshot.error.toString());
                      else
                        return Center(child: CircularProgressIndicator());
                    }),
              ),
              BlockBaseWidget(
                header: loc.translate('popular_playlists'),
                margin: EdgeInsets.zero,
                child: FutureBuilder(
                    future: Api.Entities.getAll<Models.Playlist>(1, 2),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return CustomListBuilder<Models.Playlist>(
                            type: CustomListBuilderTypes.verticalList,
                            items: snapshot.data,
                            itemBuilder: (item) => PlayListCard(
                                  model: item,
                                  aspectRatio: 16 / 9,
                                ));
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      } else
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                    }),
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
