import 'package:extreme/helpers/app_localizations_helper.dart';
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/screens/movies_screen.dart';
import 'package:extreme/screens/playlists_screen.dart';
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

/// Вторая страница - Просмотр (Browse в bottomNavigationBar)

class BrowseScreen extends StatefulWidget {
  final Key? navigatorKey;

  BrowseScreen({this.navigatorKey});

  @override
  _BrowseScreenState createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var loc = AppLocalizations.of(context)?.withBaseKey('browse_screen');

    return ScreenBaseWidget(
        appBar: AppBar(
          title: Text(loc!.translate("browse")),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pushNamed('/search');
              },
            ),
          ],
        ),
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
                  child: CustomFutureBuilder<List<Models.Sport>?>(
                      future: Api.Entities.getAll<Models.Sport>(),
                      builder: (data) {
                        data?.sort((a, b) =>
                            a.content!.name!.compareTo(b.content!.name!));
                        return CustomListBuilder(
                            childAspectRatio: 16 / 9,
                            type: CustomListBuilderTypes.grid,
                            crossAxisCount: 2,
                            items: data,
                            itemBuilder: (item) => SportCard(
                                  model: item as Models.Sport,
                                  margin: EdgeInsets.only(bottom: Indents.sm),
                                ));
                      })),
              BlockBaseWidget(
                header: loc.translate('popular_playlists'),
                margin: EdgeInsets.zero,
                child: CustomFutureBuilder<List<Models.Playlist>?>(
                  future: Api.Entities.popular<Models.Playlist>(1, 4),
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
  final String? text;
  final IconData? icon;
  final Widget? pushTo;

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
                builder: (context) => pushTo!,
              ));
            },
          ),
          Text(
            text ?? '',
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
