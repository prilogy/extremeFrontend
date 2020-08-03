import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/movie_card.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:flutter/material.dart';

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
                child: GridView.count(
                  primary: false,
                  crossAxisSpacing: Indents.md,
                  mainAxisSpacing: Indents.md,
                  childAspectRatio: 9 / 16,
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  children: [
                    for (var item in [
                      MovieCard(),
                      MovieCard(),
                      MovieCard(),
                      MovieCard(),
                      MovieCard(),
                      MovieCard(),
                      MovieCard(),
                    ])
                      item
                  ],
                ),
              ),
            ]);
  }
}
