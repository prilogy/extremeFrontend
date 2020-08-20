import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/custom_future_builder.dart';
import 'package:extreme/helpers/app_localizations_helper.dart';
import 'package:extreme/widgets/movie_card.dart';
import 'package:extreme/widgets/playlist_card.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:extreme/widgets/sport_card.dart';
import 'package:extreme/widgets/video_card.dart';
import 'package:flutter/material.dart';
import 'package:extreme/services/api/main.dart' as Api;
import 'package:extreme/models/main.dart' as Models;
import 'package:fluttertoast/fluttertoast.dart';

/// Создаёт окно поиска контента
class SearchScreen extends StatelessWidget {
  final String query;
  const SearchScreen({Key key, this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context).withBaseKey('search_screen');

    String _query = query ?? 'Поиск Extreme Insiders';
    TextEditingController _searchController = new TextEditingController();
    _searchController.text = query;
    return ScreenBaseWidget(
      appBar: AppBar(
        // titleSpacing: 10,

        title: Container(
          height: 40,
          child: TextField(
            decoration: InputDecoration(
                filled: true,
                fillColor:
                    Theme.of(context).colorScheme.background.withOpacity(0.5),
                focusColor:
                    Theme.of(context).colorScheme.background.withOpacity(0.5),
                hoverColor:
                    Theme.of(context).colorScheme.background.withOpacity(0.5),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: _query,
                suffixIcon: IconButton(
                  onPressed: () => _searchController.clear(),
                  icon: Icon(Icons.clear),
                )),
            controller: _searchController,
            onSubmitted: (query) {
              if (query.length > 2) {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed('/search', arguments: query);
              } else {
                Fluttertoast.showToast(
                    msg: loc.translate("few_symbols"),
                    backgroundColor: Colors.grey);
              }
            },
          ),
        ),
      ),
      builder: (context) => [
        CustomFutureBuilder<Models.SearchResult>(
            future: Api.Search.global(query: _query),
            builder: (data) {
              var _movies = data.movies
                  .map<Widget>((e) => MovieCard(aspectRatio: 16 / 9, model: e))
                  .toList();
              var _videos = data.videos
                  .map<Widget>((e) => VideoCard(aspectRatio: 16 / 9, model: e))
                  .toList();
              var _playlists = data.playlists
                  .map<Widget>((e) => PlayListCard(
                      aspectRatio: 16 / 9,
                      padding: EdgeInsets.symmetric(vertical: Indents.sm),
                      model: e))
                  .toList();
              var _sports = data.sports
                  .map<Widget>((e) => SportCard(
                        aspectRatio: 16 / 9,
                        model: e,
                        padding: EdgeInsets.symmetric(vertical: Indents.sm),
                      ))
                  .toList();
              List<Widget> mass;
              mass = [
                _videos.isNotEmpty
                    ? CategoryBlock(
                        header: loc.translate("videos"),
                        cards: [..._videos],
                      )
                    : Container(),
                _playlists.isNotEmpty
                    ? CategoryBlock(
                        header: loc.translate("playlists"),
                        cards: [..._playlists],
                      )
                    : Container(),
                _movies.isNotEmpty
                    ? CategoryBlock(
                        header: loc.translate("movies"),
                        cards: [..._movies],
                      )
                    : Container(),
                _sports.isNotEmpty
                    ? CategoryBlock(
                        header: loc.translate("sports"),
                        cards: [..._sports],
                        grid: true,
                      )
                    : Container(),
              ];
              return Column(
                children: mass,
              );
            })
      ],
    );
  }
}

class CategoryBlock extends StatelessWidget {
  final List<Widget> cards;
  final String header;
  final bool grid;
  const CategoryBlock({Key key, this.cards, this.header, this.grid = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!grid)
      return BlockBaseWidget(
        header: header,
        child: Column(children: cards),
      );
    else {
      return BlockBaseWidget(
        header: header,
        child: GridView.count(
          primary: false,
          crossAxisSpacing: Indents.md,
          mainAxisSpacing: Indents.md,
          childAspectRatio: 16 / 9,
          shrinkWrap: true,
          crossAxisCount: 2,
          children: cards,
        ),
      );
    }
  }
}
