import 'package:extreme/helpers/aspect_ratio_mixin.dart';
import 'package:extreme/helpers/indents_mixin.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/styles/intents.dart';
import 'package:flutter/material.dart';
import 'package:extreme/models/main.dart' as Models;
import 'package:flutter_redux/flutter_redux.dart';

import 'favorite_toggler.dart';

class MovieCard extends StatelessWidget with IndentsMixin, AspectRatioMixin {
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double aspectRatio;
  final Models.Movie model;

  MovieCard({
    this.padding,
    this.aspectRatio,
    this.margin,
    this.model,
  });
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Models.User>(
        converter: (store) => store.state.user,
        builder: (context, state) => withIndents(
              child: withAspectRatio(
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  margin: EdgeInsets.zero,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(model?.content?.image?.path ??
                            'https://img3.akspic.ru/image/20093-parashyut-kaskader-kuala_lumpur-vozdushnye_vidy_sporta-ekstremalnyj_vid_sporta-1920x1080.jpg'),
                      ),
                    ),
                    child: Container(
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: RadialGradient(
                                  colors: [
                                    Theme.of(context)
                                        .colorScheme
                                        .background
                                        .withOpacity(0),
                                    Theme.of(context)
                                        .colorScheme
                                        .background
                                        .withOpacity(0.75),
                                  ],
                                  center: Alignment.center,
                                  radius: 1.5,
                                  stops: <double>[0, 1],
                                ),
                              ),
                            ),
                          ),
                          Positioned.fill(
                              child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              // TODO: implement movie view open
                              onTap: () {},
                            ),
                          )),
                          Padding(
                            padding: const EdgeInsets.all(Indents.md),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  FavoriteToggler(
                                    id: model?.id,
                                    status: model?.isFavorite,
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }
}
