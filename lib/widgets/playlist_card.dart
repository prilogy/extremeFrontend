import 'dart:math';

import 'package:extreme/helpers/aspect_ratio_mixin.dart';
import 'package:extreme/helpers/indents_mixin.dart';
import 'package:extreme/screens/playlist_screen.dart';
import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/styles/intents.dart';
import 'package:flutter/material.dart';

import 'like_state.dart';
import 'stats.dart';
import 'package:extreme/models/main.dart' as Models;

class PlayListCard extends StatelessWidget with IndentsMixin, AspectRatioMixin {
  final Models.Playlist model;
  final bool small;
  final bool isLiked;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double aspectRatio;

  PlayListCard(
      {this.margin,
      this.padding,
      this.aspectRatio,
      this.small = false,
      this.model,
      this.isLiked = false});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    String title = model?.content?.name ?? 'Название плейлиста';
    if (!small) {
      return withIndents(
        child: withAspectRatio(
          child: Card(
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.zero,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        model?.content?.image?.path ?? 'https://img2.akspic.ru/image/1601-nebo-priklyucheniya-skachok-bejsdzhamping-kaskader-1920x1080.jpg'),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
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
                          builder: (context) => PlaylistScreen(model: model,),
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
                                      text: Random().nextInt(100).toString(),
                                      marginBetween: Indents.sm,
                                      widgetMarginRight: Indents.md,
                                    ),
                                  ),
                                  Stats(
                                      icon: Icons.local_movies,
                                      text: model?.videosIds?.length
                                              ?.toString() ??
                                          Random().nextInt(20).toString().toString(),
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
                                model?.content?.description ??
                                    'Краткое описание этого плейлиста',
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
      );
    } else {
      return withIndents(
          child: withAspectRatio(
              child: Card(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: 75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(model?.content?.image?.path ?? 'https://img2.akspic.ru/image/1601-nebo-priklyucheniya-skachok-bejsdzhamping-kaskader-1920x1080.jpg'),
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
                      builder: (context) => PlaylistScreen(model: model,),
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
                      // TODO: поменять на некостыльное
                     model?.content?.name ??'Плейлист',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )));
    }
  }
}
