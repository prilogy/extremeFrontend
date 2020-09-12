import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/custom_future_builder.dart';
import 'package:extreme/helpers/app_localizations_helper.dart';
import 'package:extreme/widgets/custom_list_builder.dart';
import 'package:extreme/widgets/movie_card.dart';
import 'package:extreme/widgets/playlist_card.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:extreme/widgets/sport_card.dart';
import 'package:extreme/widgets/video_card.dart';
import 'package:flutter/material.dart';
import 'package:extreme/services/api/main.dart' as Api;
import 'package:extreme/models/main.dart' as Models;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// Создаёт окно поиска контента
class SearchScreen extends StatefulWidget {
  final String query;

  const SearchScreen({Key key, this.query}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Widget> mass;
  bool isSearch = false;
  String hintText;
  String _query;
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context).withBaseKey('search_screen');
    hintText = loc.translate('hint');
    print(isSearch.toString());
    print(_query);
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
                    color: Theme.of(context).colorScheme.primary,
                  )),
              controller: _searchController,
              onChanged: (query) {
                if (query != _query) {
                  setState(() {
                    isSearch = false;
                    _query = query;
                  });
                }
              },
              onSubmitted: (query) {
                if (query.length > 2) {
                  setState(() {
                    isSearch = true;
                    _query = _searchController.text;
                  });
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
              isSearch
                  ? CustomFutureBuilder<Models.SearchResult>(
                      future: Api.Search.global(query: _query),
                      builder: (data) {
                        var _movies = data.movies
                            .map<Widget>((e) => MovieCard(
                                aspectRatio: 16 / 9,
                                padding:
                                    EdgeInsets.symmetric(vertical: Indents.sm),
                                model: e))
                            .toList();
                        var _videos = data.videos
                            .map<Widget>((e) => VideoCard(
                                  aspectRatio: 16 / 9,
                                  padding: EdgeInsets.symmetric(
                                      vertical: Indents.sm),
                                  model: e,
                                ))
                            .toList();
                        var _playlists = data.playlists
                            .map<Widget>((e) => PlayListCard(
                                aspectRatio: 16 / 9,
                                padding:
                                    EdgeInsets.symmetric(vertical: Indents.sm),
                                model: e))
                            .toList();
                        var _sports = data.sports
                            .map<Widget>((e) => SportCard(
                                  aspectRatio: 16 / 9,
                                  model: e,
                                  padding: EdgeInsets.symmetric(
                                      vertical: Indents.sm),
                                ))
                            .toList();
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
                  : (_query?.length ?? 0) > 1
                      ? CustomFutureBuilder(
                          future: Api.Search.predict(query: _query),
                          builder: (data) => Row(children: [
                            Flexible(
                              child: Column(
                                children: <Widget>[
                                  for (var item in data)
                                    SearchHint(
                                      text: item,
                                      onPressed: () {
                                        setState(() {
                                          _searchController.text = item;
                                        });
                                      },
                                      onIconTap: () {
                                        setState(() {
                                          _searchController.text = item;
                                          isSearch = true;
                                          _query = item;
                                        });
                                      },
                                    )
                                ],
                              ),
                            ),
                          ]),
                        )
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

class SearchHint extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Function onIconTap;

  const SearchHint(
      {Key key,
      @required this.text,
      @required this.onPressed,
      @required this.onIconTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: InkWell(
        child: Icon(Icons.search),
        onTap: onIconTap,
      ),
      title: InkWell(
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          softWrap: false,
        ),
        onTap: onIconTap,
      ),
      trailing: IconButton(
        icon: Icon(Icons.arrow_upward),
        color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
        onPressed: onPressed,
      ),
    );
  }
}
