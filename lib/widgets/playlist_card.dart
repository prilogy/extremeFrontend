import 'package:extreme/helpers/aspect_ratio_mixin.dart';
import 'package:extreme/helpers/indents_mixin.dart';
import 'package:extreme/models/main.dart';
import 'package:extreme/screens/playlist_screen.dart';
import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/styles/intents.dart';
import 'package:flutter/material.dart';

import 'like_state.dart';
import 'stats.dart';

class PlayListCard extends StatelessWidget with IndentsMixin, AspectRatioMixin {
  final bool small;
  final String title;
  final String description;
  final int likes;
  final int videos;
  final bool isLiked;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double aspectRatio;

  PlayListCard(
      {this.margin,
      this.padding,
      this.aspectRatio,
      this.small = false,
      this.title = "Название плейлиста",
      this.description = 'Краткое описание плейлиста',
      this.likes = 123,
      this.videos = 87,
      this.isLiked = false});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    if (!small) {
      return withIndents(
        child: withAspectRatio(
          child: Card(
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.zero,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: ExactAssetImage(
                      "extreme2.jpg"), // TODO: change hardcode image to var
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
                                  .withOpacity(0.32),
                              Theme.of(context)
                                  .colorScheme
                                  .background
                                  .withOpacity(0.67),
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
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PlaylistScreen(),
                          ));
                        },
                      ),
                    )),
                    Padding(
                      padding: const EdgeInsets.all(Indents.md),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Like(
                                  isLiked: isLiked,
                                ),
                              ]),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      child: Stats(
                                        icon: Icons.thumb_up,
                                        text: likes.toString(),
                                        marginBetween: Indents.sm,
                                        widgetMarginRight: Indents.md,
                                      ),
                                    ),
                                    Stats(
                                        icon: Icons.local_movies,
                                        text: videos.toString(),
                                        marginBetween: Indents.sm),
                                  ],
                                ),
                                Text(title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .merge(TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary))),
                                Text(
                                  description,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .merge(new TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary)),
                                ),
                              ]),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return withIndents(
          child: withAspectRatio(
              child: Stack(
        children: [
          Container(
            height: 75,
            margin: EdgeInsets.only(right: Indents.sm, left: Indents.sm),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: ExactAssetImage("extreme2.jpg"),
              ),
            ),
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(Indents.sm),
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [
                        Theme.of(context)
                            .colorScheme
                            .background
                            .withOpacity(0.19),
                        Theme.of(context)
                            .colorScheme
                            .background
                            .withOpacity(0.53),
                      ],
                      center: Alignment.center,
                      radius: 1.5,
                      stops: <double>[0, 1],
                    ),
                  ),
                ),
                Positioned.fill(
                    child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PlaylistScreen(),
                      ));
                    },
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.all(Indents.sm),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Плейлист',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      )));
    }
  }
}
