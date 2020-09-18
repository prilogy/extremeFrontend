import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/custom_future_builder.dart';
import 'package:extreme/helpers/app_localizations_helper.dart';
import 'package:extreme/widgets/movie_card.dart';
import 'package:extreme/widgets/playlist_card.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:extreme/widgets/video_card.dart';
import 'package:flutter/material.dart';
import 'package:extreme/services/api/main.dart' as Api;
import 'package:extreme/models/main.dart' as Models;
import 'package:fluttertoast/fluttertoast.dart';

/// Создаёт окно поиска контента внутри плейлиста или спорт
class SearchInEntityScreen extends StatefulWidget {
  final String query;
  final int id;
  // если не спорт, то плейлист
  final bool isSport; 
  const SearchInEntityScreen(
      {Key key, this.query, @required this.isSport, @required this.id})
      : super(key: key);

  @override
  _SearchInEntityScreen createState() => _SearchInEntityScreen();
}

class _SearchInEntityScreen extends State<SearchInEntityScreen> {
  List<Widget> mass;
  String hintText;
  String _query;
  bool isSearch = false;
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context).withBaseKey('search_screen');
    // _searchController.text = widget.query;
    return ScreenBaseWidget(
        appBar: AppBar(
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
                  hintText: hintText,
                  suffixIcon: IconButton(
                    onPressed: () => _searchController.clear(),
                    icon: Icon(Icons.clear),
                  )),
              controller: _searchController,
              onSubmitted: (query) {
                if (query.length > 2) {
                  setState(() {
                    _query = _searchController.text;
                    hintText = _query;
                    isSearch = true;
                    _searchController.clear();
                  });
                } else {
                  Fluttertoast.showToast(
                      msg: loc.translate("few_symbols"),
                      backgroundColor: Colors.black.withOpacity(0.5));
                }
              },
            ),
          ),
        ),
        builder: (context) => [
              isSearch
                  ? CustomFutureBuilder<Models.SearchResult>(
                      future: widget.isSport
                          ? Api.Search.inSport(widget.id, query: _query)
                          : Api.Search.inPlaylist(widget.id, query: _query),
                      builder: (data) {
                        var _movies;
                        var _videos;
                        var _playlists;
                        if (widget.isSport) {
                          _playlists = data.playlists
                              .map<Widget>((e) => PlayListCard(
                                  aspectRatio: 16 / 9,
                                  padding: EdgeInsets.symmetric(
                                      vertical: Indents.sm),
                                  model: e))
                              .toList();
                          _movies = widget.isSport
                              ? null
                              : data.movies
                                  .map<Widget>((e) => MovieCard(
                                      aspectRatio: 16 / 9,
                                      padding: EdgeInsets.symmetric(
                                          vertical: Indents.sm),
                                      model: e))
                                  .toList();
                        }

                        _videos = data.videos
                            .map<Widget>((e) => VideoCard(
                                  aspectRatio: 16 / 9,
                                  padding: EdgeInsets.symmetric(
                                      vertical: Indents.sm),
                                  model: e,
                                ))
                            .toList();

                        mass = [
                          _videos?.isNotEmpty ?? false
                              ? CategoryBlock(
                                  header: loc.translate("videos"),
                                  cards: [..._videos],
                                )
                              : Container(),
                          _playlists?.isNotEmpty ?? false
                              ? CategoryBlock(
                                  header: loc.translate("playlists"),
                                  cards: [..._playlists],
                                )
                              : Container(),
                          _movies?.isNotEmpty ?? false
                              ? CategoryBlock(
                                  header: loc.translate("movies"),
                                  cards: [..._movies],
                                )
                              : Container(),
                        ];
                        return Column(
                          children: mass,
                        );
                      })
                  : Container()
            ]);
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
