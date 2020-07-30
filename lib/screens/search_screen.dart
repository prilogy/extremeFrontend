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
    //_searchController.text = 'test';
    return ScreenBaseWidget(
      appBar: AppBar(
        title: TextField(
          decoration:
              // TODO: если переход был вместе с текстом запроса, то _query должен быть в _searchController, а не в hint
              InputDecoration.collapsed(hintText: _query),
          controller: _searchController,
          onSubmitted: (query) {
            if (query.length > 2) {
              Navigator.of(context, rootNavigator: true)
                  .pushNamed('/search', arguments: query);
            } else {
              //Scaffold.of(context).showSnackBar(SnackBar(content: Text(' А больше 2 пожалуйста')));
              Fluttertoast.showToast(
                  msg: 'Поисковой запрос должен иметь больше 2 символов',
                  backgroundColor: Colors.grey);
            }
          },
        ),
      ),
      builder: (context) => [
        FutureBuilder<Models.SearchResult>(
            future: Api.Search.global(query: _searchController.text),
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
                  CategoryBlock(
                    header:"Видео",
                    cards: [..._videos],
                  ),
                  CategoryBlock(
                    header:"Плейлисты",
                    cards: [..._playlists],
                  ),
                  CategoryBlock(
                    header:"Фильмы",
                    cards: [..._movies],
                  ),
                  CategoryBlock(
                    header:"Виды спорта",
                    cards: [..._sports],
                  ),
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
  const CategoryBlock({Key key, this.cards, this.header}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlockBaseWidget(
      header: header,
      child: Column(children: cards),
    );
  }
}
