import 'package:extreme/helpers/aspect_ratio_mixin.dart';
import 'package:extreme/helpers/indents_mixin.dart';
import 'package:extreme/styles/intents.dart';
import 'package:flutter/material.dart';
import 'package:extreme/models/main.dart' as Models;

import 'like_state.dart';

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
                image: 
                ExactAssetImage(
                    "assets/images/extreme2.jpg"), // TODO: change hardcode image to var
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
                            Theme.of(context).colorScheme.background.withOpacity(0),
                            Theme.of(context).colorScheme.background.withOpacity(0.75),
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
                      onTap: () {},
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
                                isLiked: false,
                              ),
                            ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                model?.content?.name ?? 'Фильм',
                                style: TextStyle(
                                  // TODO: исправить текст стайл
                                  letterSpacing: 0.8,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Roboto',
                                  fontSize: 20.0,
                                ),
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
  }
}
