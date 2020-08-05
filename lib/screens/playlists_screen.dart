import 'package:extreme/main.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/playlist_card.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:extreme/widgets/sport_card.dart';
import 'package:flutter/material.dart';
import 'package:extreme/models/main.dart' as Models;

typedef ItemBuilder<T> = Widget Function(T model);

class CustomListBuilder<T> extends StatelessWidget {
  final List<T> items;
  final ItemBuilder<T> itemBuilder;
  // isGrid                 ------|
  // isScrollableList (типа вбок)-| Вообще это все можно объединить в enum чисто для удобства,
  // isSmth ещё что то и тд   ----| чтобы всегда конкретно один тип задавался
  // itemMargin                   \ напр enum CustomListBuilderTypes { verticalList, grid, scrollableList }

  CustomListBuilder({@required this.items, @required this.itemBuilder});

  @override
  Widget build(BuildContext context) {
    var widgetItems = items.map<Widget>((e) => itemBuilder(e)).toList();

    // if(isGrid) GridView...
    // else if()
    return ListView(
      shrinkWrap: true,
      primary: false,
      children: <Widget>[
        for (var item in widgetItems)
          Container(
            margin: EdgeInsets.only(
                bottom: widgetItems.last == item ? 0 : Indents.md),
            child: item,
          )
      ],
    );
  }
}

class Playlists extends StatelessWidget {
  //const Playlists({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenBaseWidget(
      appBar: AppBar(title: Text('Плейлисты')),
      builder: (context) => [
        BlockBaseWidget(
            margin: EdgeInsets.only(bottom: 0),
            child: CustomListBuilder<Models.Playlist>(items: [
              Models.Playlist(),
              Models.Playlist(),
              Models.Playlist(),
              Models.Playlist()
            ], itemBuilder: (item) => PlayListCard(aspectRatio: 16 / 9)))
        /*
        BlockBaseWidget(
                //header: "Популярные плейлисты",
                margin: EdgeInsets.zero,
                child: ListView(
                  shrinkWrap: true,
                  primary: false,
                  children: [
                    for (var item in [
                      PlayListCard(
                        aspectRatio: 16 / 9,
                        padding: EdgeInsets.only(bottom: Indents.md),
                        isLiked: false,
                      ),
                      PlayListCard(
                        aspectRatio: 16 / 9,
                        padding: EdgeInsets.only(bottom: Indents.md),
                        isLiked: true,
                      ),
                      PlayListCard(
                        aspectRatio: 16 / 9,
                        padding: EdgeInsets.only(bottom: Indents.md),
                        isLiked: false,
                      ),
                      PlayListCard(
                        aspectRatio: 16 / 9,
                        padding: EdgeInsets.only(bottom: Indents.md),
                        isLiked: true,
                      ),
                      PlayListCard(
                        aspectRatio: 16 / 9,
                        padding: EdgeInsets.only(bottom: Indents.md),
                        isLiked: false,
                      ),
                      PlayListCard(
                        aspectRatio: 16 / 9,
                        padding: EdgeInsets.only(bottom: Indents.md),
                        isLiked: true,
                      ),
                    ])
                      item
                  ],
                ),
              ),*/
      ],
    );
  }
}
