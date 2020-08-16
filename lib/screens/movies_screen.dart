import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/custom_future_builder.dart';
import 'package:extreme/widgets/custom_list_builder.dart';
import 'package:extreme/widgets/movie_card.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:flutter/material.dart';
import 'package:extreme/services/api/main.dart' as Api;
import 'package:extreme/models/main.dart' as Models;

/// Страница со списком фильмов
class MoviesList extends StatelessWidget {
  const MoviesList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenBaseWidget(
        appBar: AppBar(
          title: Text('Фильмы'),
        ),
        builder: (context) => [
              BlockBaseWidget(
                child: CustomFutureBuilder<List<Models.Movie>>(
                  future: Api.Entities.getAll<Models.Movie>(1, 10),
                  builder: (data) => CustomListBuilder(
                      childAspectRatio: 9 / 16,
                      type: CustomListBuilderTypes.grid,
                      crossAxisCount: 3,
                      items: data,
                      itemBuilder: (item) => MovieCard(model: item)),
                ),
              ),
            ]);
  }
}
