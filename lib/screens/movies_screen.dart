import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/custom_list_builder.dart';
import 'package:extreme/widgets/movie_card.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:flutter/material.dart';
import 'package:extreme/services/api/main.dart' as Api;

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
                child: FutureBuilder(
                  future: Api.Entities.movies(1, 10),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return CustomListBuilder(
                        childAspectRatio: 9/16,
                          type: CustomListBuilderTypes.grid,
                          crossAxisCount: 3,
                          items: snapshot.data,
                          itemBuilder: (item) =>
                              MovieCard(model: item));
                    } else if (snapshot.hasError)
                    {
                      return Text(snapshot.error.toString());
                    } else return Center(child: CircularProgressIndicator(),);
                  },
                ),
              ),
            ]);
  }
}
