import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
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
    String _query = query ?? 'Поиск Extreme Insiders';
    print('_query: ' + _query);
    TextEditingController _searchController = new TextEditingController();
    _searchController.text = query;
    return ScreenBaseWidget(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration.collapsed(hintText: _query),
          controller: _searchController,
          onSubmitted: (query) {
            if (query.length > 2) {
              Navigator.of(context, rootNavigator: true)
                  .pushNamed('/search', arguments: query);
            } else {
              Fluttertoast.showToast(
                  msg: 'Поисковой запрос должен иметь больше 2 символов',
                  backgroundColor: Colors.grey);
            }
          },
        ),
      ),
      builder: (context) => [
        FutureBuilder<Models.SearchResult>(
            future: Api.Search.global(query: _query),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var _movies = snapshot.data.movies
                    .map<Widget>(
                        (e) => MovieCard(aspectRatio: 16 / 9, model: e))
                    .toList();
                var _videos = snapshot.data.videos
                    .map<Widget>(
                        (e) => VideoCard(aspectRatio: 16 / 9, model: e))
                    .toList();
                var _playlists = snapshot.data.playlists
                    .map<Widget>((e) => PlayListCard(
                        aspectRatio: 16 / 9,
                        padding: EdgeInsets.symmetric(vertical: Indents.sm),
                        model: e))
                    .toList();
                var _sports = snapshot.data.sports
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
                          header: "Видео",
                          cards: [..._videos],
                        )
                      : Container(),
                  _playlists.isNotEmpty
                      ? CategoryBlock(
                          header: "Плейлисты",
                          cards: [..._playlists],
                        )
                      : Container(),
                  _movies.isNotEmpty
                      ? CategoryBlock(
                          header: "Фильмы",
                          cards: [..._movies],
                        )
                      : Container(),
                  _sports.isNotEmpty
                      ? CategoryBlock(
                          header: "Виды спорта",
                          cards: [..._sports],
                          grid: true,
                        )
                      : Container(),
                ];
                return Column(
                  children: mass,
                );
              } else if (snapshot.hasError)
                return (Text(snapshot.error.toString()));
              return Container(
                  alignment: Alignment.center,
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator());
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
